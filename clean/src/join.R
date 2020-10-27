library(dplyr)
library(here)
library(readr)
library(sf)
library(stringr)

INDIR = here::here("clean/output")
SHAPEFILE = here::here("extract/output/school-districts.geojson")
ENROLLMENT_FILE = file.path(INDIR, "enrollment_2018-19.csv")
REVENUE_FILE = file.path(INDIR, "revenue_2018-19.csv")
OUTFILE_BASE = file.path(INDIR, "final")

enrollment =
  readr::read_csv(ENROLLMENT_FILE) %>%
  dplyr::mutate(
    district = dplyr::recode(
      district,
      "New Castle County Vocational-Technical" = "NCC Votech",
      "POLYTECH" = "Polytech"
    )
  )
revenue = readr::read_csv(REVENUE_FILE)
joined = enrollment %>%
  dplyr::left_join(revenue, by = "district") %>%
  dplyr::mutate(
    opp_funding =
      (300 * students_low_income) + (500 * students_english_learners),
    opp_funding_pp = opp_funding / fall_enrollment,
    state_local_opp_revenue_pp = state_local_revenue_pp + opp_funding_pp
  )

sd_raw = sf::st_read(SHAPEFILE)
sd_clean = sd_raw %>%
  dplyr::mutate(
    district = NAME %>%
      stringr::str_replace_all(c("SCHOOL DISTRICT|CONSOLIDATED" = "")) %>%
      stringr::str_to_title() %>%
      stringr::str_squish()
  ) %>%
  dplyr::left_join(joined, by = "district")

readr::write_csv(joined, paste0(OUTFILE_BASE, ".csv"))
sf::st_write(sd_clean, paste0(OUTFILE_BASE, ".geojson"), delete_dsn = TRUE)
