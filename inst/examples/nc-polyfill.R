library(sf)
library(h3)

nc <- st_read(system.file("shape/nc.shp", package = "sf"),  quiet = TRUE) %>%
  st_transform(4326)
nc_polygons <- st_cast(nc, "POLYGON") %>%
  st_geometry()

out <- lapply(seq_along(nc_polygons), function(i) polyfill(nc_polygons[i], res = 5)) %>%
  do.call(c, .)
