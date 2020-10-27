library(dplyr)
library(here)
library(readr)

INFILE = here::here(
  "extract",
  "output",
  "Fiscal_district_financial_report_REGULAR_SCHOOL_V3-page-11-table-1.csv"
)
OUTFILE = here::here("clean/output/revenue_2018-19.csv")

rev = readr::read_csv(INFILE)
old_names = gsub("^X\\d", "", names(rev))
new_names = paste0(old_names, rev[1,])
rev_clean = rev %>%
  `names<-`(new_names) %>%
  dplyr::as_tibble(.name_repair = "universal") %>%
  dplyr::rename_with(
    ~dplyr::recode(
      .,
      "RevenueTotal" = "state_revenue_pp",
      "Revenue_1Total" = "federal_revenue_pp",
      "Revenue_2Total" = "local_revenue_pp",
      "Revenue_3Total" = "total_revenue_pp"
    )
  ) %>%
  dplyr::slice(-1) %>%
  dplyr::mutate(
    County =
      dplyr::case_when(is.na(Enrollment) ~ District) %>%
      stringr::str_remove_all("COUNTY") %>%
      stringr::str_to_title() %>%
      stringr::str_squish()
  ) %>%
  tidyr::fill(County, .direction = "down") %>%
  dplyr::relocate(County, .after = District)
rev_uni = rev_clean %>%
  dplyr::filter(!is.na(Enrollment)) %>%
  dplyr::select(district = District, dplyr::matches("(state|local)_"))
rev_calc = rev_uni %>%
  dplyr::mutate(
    dplyr::across(dplyr::ends_with("_revenue_pp"), readr::parse_number),
    state_local_revenue_pp = state_revenue_pp + local_revenue_pp
  ) %>%
  dplyr::relocate(
    dplyr::contains("_revenue_pp"), .after = dplyr::everything()
  )
readr::write_csv(rev_calc, OUTFILE)
cat(glue::glue("{OUTFILE} saved."))
