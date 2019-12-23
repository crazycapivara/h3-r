nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"),  quiet = TRUE) %>%
  sf::st_transform(4326)
h3_indexes <- polyfill(nc[1, ], res = 7)
