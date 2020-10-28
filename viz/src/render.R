library(rmarkdown)

rmarkdown::render(
  here::here("viz/src/viz.Rmd"),
  output_file = here::here("viz/output/Aid-Doesnt-Follow-Need.html")
)
