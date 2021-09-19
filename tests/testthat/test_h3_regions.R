context("H3 regions")

read_nc <- function() {
  sf::st_read(system.file("shape/nc.shp", package = "sf"),  quiet = TRUE) %>%
    sf::st_transform(4326)
}

test_that("polyfill matrix", {
  # Prepare
  resolution <- 7
  nc <- read_nc()
  latlng <- c("Y", "X")
  polygon <- sf::st_coordinates(nc[1, ])[, latlng]

  # Act
  h3_indexes <- polyfill(polygon, resolution)

  # Assert
  expect_length(h3_indexes, 237)
})

test_that("polyfill sf/sfc", {
  # Prepare
  resolution <- 7
  nc <- read_nc()

  # Act
  h3_indexes <- polyfill(nc, 7)

  # Assert
  expect_length(h3_indexes, 237)
})

test_that("polyfill sf/sfc MULTIPOLYGON", {
  # Prepare
  reseoltion <- 7
  multipolygon_sf <- read_nc()[4, ]

  # Act
  h3_indexes <- polyfill(multipolygon_sf, 7)

  # Assert
  expect_is(st_geometry(multipolygon_sf), "sfc_MULTIPOLYGON")
  expect_length(h3_indexes, 145)
})
