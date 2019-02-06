library(h3)
library(tibble)
library(dplyr)
library(leaflet)

h3_index <- geo_to_h3(road_safety_greater_manchester)
tbl <- table(h3_index) %>%
  as_tibble()
hexagons <- h3_to_geo_boundary_sf(tbl$h3_index) %>%
  mutate(index = tbl$h3_index, accidents = tbl$n)

pal <- colorBin("YlOrRd", domain = hexagons$accidents)

map <- leaflet(data = hexagons) %>%
  addProviderTiles("Stamen.Toner") %>%
  addPolygons(
    weight = 2,
    color = "white",
    fillColor = ~ pal(accidents),
    fillOpacity = 0.8,
    label = ~ sprintf("%i accidents", accidents)
  )

if (interactive()) map
