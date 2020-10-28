# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/viz/src/render.R

library(rmarkdown)

rmarkdown::render(
  here::here("viz/src/report.Rmd"),
  output_file = here::here("viz/output/Aid-Doesnt-Follow-Need.html")
)
