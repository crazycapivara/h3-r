devtools::load_all()

library(sf)

item_sf <- sf::st_read("https://gist.githubusercontent.com/hdrs/f273f2820d40d45f8ecda49840bec521/raw/9fdebbaefcb811b9c554a18e73e47d69abb8a54b/map.geojson")

h3_ids <- polyfill(item_sf, res=10)
h3_ids %>% h3_to_geo_boundary_sf() %>%
  plot()

st_geometry(item_sf) %>%
  plot(add = TRUE)

#
polyfill_multipolygon <- function(polygon, res = 7) {
  latlng <- c("Y", "X")
  sf::st_coordinates(polygon[1]) %>%
    as.data.frame() %>%
    dplyr::group_split(L2) %>%
    purrr::map(~ as.matrix(.x[, latlng]) %>% polyfill(res)) %>%
    unlist()
}

item_sf %>% polyfill(10) %>%
  h3_to_geo_boundary_sf() %>% plot()

st_geometry(item_sf) %>%
  plot(add = TRUE)
