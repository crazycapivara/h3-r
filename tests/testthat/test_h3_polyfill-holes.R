context("h3 regions")

test_that("polygon has holes", {
  # Prepare
  polygon <- readRDS(test_path("testdata", "holes.sf.rds"))

  # Act
  has_holes <- sfc_polygon_has_holes(polygon)

  # Assert
  expect_true(has_holes)
})

test_that("polyfill with holes", {
  # Prepare
  resolution <- 8
  polygon <- readRDS(test_path("testdata", "holes.sf.rds"))
  polygon_without_holes <- sfheaders::sf_remove_holes(polygon)

  # Act
  h3_idx <- polyfill(polygon, res = resolution)
  h3_idx_without_holes <- polyfill(polygon_without_holes, res = resolution)

  # Assert
  expect_length(h3_idx, 547)
  expect_length(h3_idx_without_holes, 551)
})
