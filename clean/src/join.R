# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/clean/src/join.R

library(dplyr)
library(here)
library(readr)
library(sf)
library(stringr)

INDIR = here::here("clean/output")
DISTRICTS_FILE = here::here("extract/output/Student_Enrollment.csv")
SHAPEFILE = here::here("extract/output/school-districts.geojson")
ENROLLMENT_FILE = file.path(INDIR, "enrollment_2019-20.csv")
REVENUE_FILE = file.path(INDIR, "revenue_2018-19.csv")
OPPFUN_FILE = file.path(INDIR, "opportunity-funding_2019-20.csv")
OUTFILE_BASE = file.path(INDIR, "final")

school_districts =
  readr::read_csv(DISTRICTS_FILE) %>%
  dplyr::pull(District) %>%
  unique() %>%
  stringr::str_to_title() %>%
  stringr::str_replace_all(
    c(
      " (Consolidated )*School District$" = "",
      "New Castle County Vocational-Technical" = "NCC Votech"
    )
  )
districts_shape =
  sf::st_read(SHAPEFILE) %>%
  dplyr::mutate(
    district = NAME %>%
      stringr::str_replace_all(c("SCHOOL DISTRICT|CONSOLIDATED" = "")) %>%
      stringr::str_to_title() %>%
      stringr::str_squish()
  ) %>%
  dplyr::relocate(district, .before = dplyr::everything()) %>%
  dplyr::select(-NAME)
enrollment =
  readr::read_csv(ENROLLMENT_FILE) %>%
  dplyr::mutate(
    school_districts_charters = school_districts_charters %>%
      stringr::str_to_title() %>%
      dplyr::recode(
        "New Castle County Vo-Tech" = "NCC Votech",
        "Sussex Tech" = "Sussex Technical"
      )
  ) %>%
  dplyr::filter(school_districts_charters %in% school_districts) %>%
  dplyr::select(
    district = school_districts_charters,
    enrollment,
    low_income,
    el
  ) %>%
  dplyr::mutate(pct_low_income = low_income / enrollment) %>%
  dplyr::rename_with(~paste0(., "_1920"), -district)
revenue =
  readr::read_csv(REVENUE_FILE) %>%
  dplyr::rename_with(~paste0(., "_1819"), -district)
oppfun =
  readr::read_csv(OPPFUN_FILE) %>%
  dplyr::mutate(
    district = district %>%
      stringr::str_to_title() %>%
      dplyr::recode("Nccvt" = "NCC Votech", "Sussex Tech" = "Sussex Technical")
  ) %>%
  dplyr::rename_with(~paste0(., "_1920"), -district)
joined_df = enrollment %>%
  dplyr::left_join(revenue, by = "district") %>%
  dplyr::left_join(oppfun, by = "district") %>%
  dplyr::mutate(
    opp_fund_pp_1920 = opp_fund_1920 / enrollment_1920,
    state_local_revenue_opp_fund_pp =
      state_local_revenue_pp_1819 + opp_fund_pp_1920
  )
joined_sf = joined_df %>%
  # The techs aren't in the shapefile.
  # Christina appears twice in shapefile because it has two pieces.
  dplyr::inner_join(districts_shape, by = "district")

sf::st_write(joined_sf, paste0(OUTFILE_BASE, ".geojson"), delete_dsn = TRUE)
readr::write_csv(joined_df, paste0(OUTFILE_BASE, ".csv"))
