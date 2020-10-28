library(dplyr)
library(here)
library(janitor)
library(readr)
library(readxl)

INFILE = here::here("clean/input/Enrollment-and-Unit-Data-Sen-Poore.xlsx")
OUTFILE = here::here("clean/output/enrollment_2019-20.csv")

enr_raw = readxl::read_excel(INFILE, skip = 2)
enr_clean = enr_raw %>%
  dplyr::rename(enrollment = Total) %>%
  dplyr::rename_with(~stringr::str_remove(., " Students")) %>%
  dplyr::select(!dplyr::matches("\\.{3}\\d")) %>%
  janitor::clean_names() %>%
  dplyr::filter(!is.na(enrollment))

readr::write_csv(enr_clean, OUTFILE)
