library(ggplot2)
library(readr)

data = readr::read_csv("clean/output/final.csv")
data_long = data %>%
  tidyr::pivot_longer(cols = dplyr::ends_with("pp"))
data %>%
  ggplot2::ggplot() +
  geom_bar(aes(x = District, y = state_local_revenue_pp), stat = "identity")
