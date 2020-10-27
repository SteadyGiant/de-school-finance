library(dplyr)
library(ggplot2)
library(scales)
library(stats)


cma = scales::comma_format(accuracy = 1)


pct = scales::percent_format(accuracy = 1)


add_theme = function() ggplot2::theme_bw()


format_y_axis = function() {
  ggplot2::scale_y_continuous(
    labels = scales::dollar, limits = c(0, 24000), expand = c(0, 0)
  )
}


# Note: Input `revenue_long` must be a DataFrame/Tibble with a column named `y_var`, which will be the y-axis of the bar chart.
stacked_bar_revenue = function(revenue_long, title, palette) {
  p = revenue_long %>%
    ggplot2::ggplot(
      ggplot2::aes(x = stats::reorder(
        district, pct_fall_enrollment_low_income), y = value
      )
    ) +
    ggplot2::geom_bar(
      ggplot2::aes(fill = name),
      position = "stack",
      stat = "identity"
    ) +
    ggplot2::geom_text(
      ggplot2::aes(
        label = dplyr::if_else(
          name == "State",
          pct(pct_fall_enrollment_low_income),
          NULL
        ),
        y = y_var
      ),
      vjust = -0.3,
      size = 3
    ) +
    add_theme() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, vjust = 1, hjust = 1)
    ) +
    format_y_axis() +
    scale_fill_manual(values = palette) +
    ggplot2::labs(
      title = title,
      x = "",
      y = y_lab,
      fill = "",
      caption = caption_bar
    )
  return(p)
}