context("regions")

test_that("polyfill matrix", {
  # Prepare
  resolution <- 7
  nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"),  quiet = TRUE) %>%
    sf::st_transform(4326)
  lnglat <- c("X", "Y")
  polygon <- sf::st_coordinates(nc[1, ])[, lnglat]

  # Act
  h3_indexes <- polyfill(polygon, resolution)

  # Assert
  expect_length(h3_indexes, 237)
})
