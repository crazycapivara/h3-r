library(sf)

nc <- system.file("shape/nc.shp", package = "sf") %>% st_read()
nc4326 <- st_transform(nc, 4326)
# st_bbox(nc4326)

p <- nc4326[1, ]
# st_centroid(nc4326)

centers <- st_centroid(p) %>% h3::geo_to_h3() %>% h3::k_ring(10) %>% h3::h3_to_geo_sf()
result <- st_intersection(centers, p)
resultp <- h3::geo_to_h3(result) %>% h3::h3_to_geo_boundary_sf()

st_geometry(result) %>% plot()
st_geometry(resultp) %>% plot()
st_geometry(p) %>% plot(add = TRUE)

polyfill <- function(polygon, res = 7) {
  bbox <- sf::st_bbox(sf::st_geometry(polygon))
  root <- sf::st_centroid(polygon) %>% geo_to_h3(res)
  target1 <- bbox[c("ymin", "xmin")] %>% geo_to_h3(res)
  target2 <- bbox[c("ymax", "xmax")] %>% geo_to_h3(res)
  radius <- max(h3_distance(root, target1), h3_distance(root, target2))
  print(radius)
  h3_indexes <- k_ring(root, radius)
  points <- h3_to_geo_sf(h3_indexes)
  points$h3 <- h3_indexes
  sf::st_intersection(sf::st_geometry(points), sf::st_geometry(polygon))
}
