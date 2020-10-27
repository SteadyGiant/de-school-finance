library(dplyr)
library(here)
library(janitor)
library(readr)
library(readxl)
library(stringr)

INFILE = here::here(
  "clean/input/Enrollment-and-Unit-Data-Sen-Poore.xlsx"
)
OUTFILE = here::here("clean/output/enrollment_2019-20.csv")

school_districts =
  readr::read_csv("extract/output/Student_Enrollment.csv") %>%
  dplyr::pull(District) %>%
  unique() %>%
  stringr::str_to_title() %>%
  stringr::str_replace_all(
    c(
      " (Consolidated )*School District$" = "",
      "New Castle County" = "NCC",
      "Vocational-" = "Vo",
      "Technical" = "Tech"
    )
  )
rev_raw = readxl::read_excel(INFILE, skip = 2)
rev_clean = rev_raw %>%
  dplyr::rename(enrollment = Total) %>%
  dplyr::rename_with(~stringr::str_remove(., " Students")) %>%
  dplyr::select(!dplyr::matches("\\.{3}\\d")) %>%
  janitor::clean_names() %>%
  dplyr::filter(
    !is.na(enrollment),
    school_districts_charters %in% school_districts
  ) %>%
  dplyr::rename(district = school_districts_charters)

readr::write_csv(rev_clean, OUTFILE)
