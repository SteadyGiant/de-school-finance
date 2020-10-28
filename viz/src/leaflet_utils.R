# Authors:     Everet
# Maintainers: Everet
# Copyright:   2020, Everet, AGPL 3.0 or later
# =========================================
# DE-school-finance/viz/src/leaflet_utils.R

library(htmltools)
library(htmlwidgets)
library(leaflet)


make_basemap = function(.data) {
  return(
    .data %>%
      leaflet::leaflet() %>%
      leaflet::addProviderTiles(leaflet::providers$CartoDB.Positron) %>%
      leaflet::setView(lng = -75.5243682, lat = 39.158168, zoom = 8)
  )
}


fix_legend = function(.leaflet) {
  # NA entry in legend is squished. Fix that:
  # https://github.com/rstudio/leaflet/issues/615
  # CSS to correct spacing
  css_fix = "div.info.legend.leaflet-control br {clear: both;}"
  # Convert CSS to HTML
  html_fix = htmltools::tags$style(type = "text/css", css_fix)
  # Insert into leaflet HTML code
  return(htmlwidgets::prependContent(.leaflet, html_fix))
}


make_leaflet = function(
  .data, shade_var, title = "", shade_pal = "Reds", tooltip = NULL,
  legend_label_prefix = ""
) {
  # https://stackoverflow.com/a/56334156/8605348
  pal = leaflet::colorNumeric(palette = shade_pal, domain = shade_var)
  pal_legend = leaflet::colorNumeric(
    palette = shade_pal, domain = shade_var, reverse = TRUE
  )
  if (!is.null(tooltip)) tooltip = lapply(tooltip, htmltools::HTML)
  return(
    .data  %>%
      make_basemap() %>%
      leaflet::addPolygons(
        fillColor = ~pal(shade_var),
        fillOpacity = 1,
        color = "black",
        weight = 1,
        highlightOptions = leaflet::highlightOptions(
          color = 'white', weight = 3
        ),
        label = tooltip,
        labelOptions = leaflet::labelOptions(
          direction = "auto",
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px"
        )
      ) %>%
      leaflet::addLegend(
        title = title,
        pal = pal_legend,
        values = ~shade_var,
        labFormat = leaflet::labelFormat(
          transform = function(x) sort(x, decreasing = TRUE),
          prefix = legend_label_prefix
        ),
        opacity = 1,
        position = "topright"
      ) %>%
      fix_legend()
  )
}
