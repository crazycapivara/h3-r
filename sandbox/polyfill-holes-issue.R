item <- sf::st_read("https://gist.githubusercontent.com/hdrs/34eb2042bacce0eee58dbe08fbcc8af8/raw/494b6c914443540a459088ed8d26e34732661967/map.geojson")

# saveRDS(item, "sandbox/holes.sf.rds")

item_without_holes <- sfheaders::sf_remove_holes(item)

item_diff <- sf::st_difference(item_without_holes, item)

st_geometry(item) %>% plot()
st_geometry(item_diff) %>% plot(add = TRUE, col = "blue")

res <- 8

idx1 <- h3::polyfill(item_diff, res = res)
idx2 <- h3::polyfill(item_without_holes, res = res)

idx_ <- idx2[!idx2 %in% idx1]

st_geometry(item) %>% plot(col = "blue")

idx_ %>%
  h3::h3_to_geo_boundary_sf() %>%
  st_geometry() %>% plot(add = TRUE, col = "green")

st_geometry(item) %>% plot(add = TRUE)
