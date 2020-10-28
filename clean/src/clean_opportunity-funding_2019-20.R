library(dplyr)
library(purrr)
library(readr)
library(stringr)

INDIR = here::here("extract/output/Opportunity-Funding_contracttotals")
OUTFILE = here::here("clean/output/opportunity-funding_2019-20.csv")

files = list.files(INDIR, full.names = TRUE)
oppfun_mhr =
  purrr::map_dfr(files, ~readr::read_csv(., col_names = FALSE)) %>%
  `names<-`(stringr::str_squish(.[1,])) %>%
  dplyr::slice(-1)
oppfun = oppfun_mhr %>%
  dplyr::select(`District Funding`) %>%
  dplyr::mutate(
    district = `District Funding` %>%
      stringr::str_extract("^([A-Za-z]|\\s|:)+(?=\\$)") %>%
      stringr::str_squish(),
    opp_fund = `District Funding` %>%
      stringr::str_extract("\\$(\\d|,|\\s)+(?=\\(OF\\)|$)") %>%
      readr::parse_number()
  ) %>%
  dplyr::select(-`District Funding`)

readr::write_csv(oppfun, OUTFILE)
