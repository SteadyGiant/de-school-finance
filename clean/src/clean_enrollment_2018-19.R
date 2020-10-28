library(dplyr)
library(here)
library(readr)
library(tidyr)

INFILE = here::here("extract/output/Student_Enrollment.csv")
OUTFILE = here::here("clean/output/enrollment_2018-19.csv")

enr = readr::read_csv(INFILE)
enr_clean = enr %>%
  dplyr::mutate(
    District = gsub(" (Consolidated )*School District$", "", District)
  ) %>%
  dplyr::rename(fall_enrollment = FallEnrollment) %>%
  dplyr::mutate(pct_fall_enrollment = Students / fall_enrollment)
enr_uni = enr_clean %>%
  dplyr::select(
    District, fall_enrollment, SubGroup, Students, pct_fall_enrollment
  )
enr_wide = enr_uni %>%
  tidyr::pivot_wider(
    id_cols = c(District, fall_enrollment),
    names_from = SubGroup,
    values_from = c(Students, pct_fall_enrollment),
    names_repair = ~gsub(" ", "_", .)
  ) %>%
  dplyr::rename_with(tolower)

readr::write_csv(enr_wide, OUTFILE)
