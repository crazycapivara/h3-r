context("H3 indexing")

test_that("geo to H3", {
  # Prepare
  coords <- road_safety_greater_manchester[1:2, ]

  # Act
  indexes <- geo_to_h3(coords)

  # Assert
  expect_length(indexes, 2)
  expect_equal(indexes, c("87195186bffffff", "871951b36ffffff"))
})

test_that("H3 to geo", {
  # Prepare
  indexes <- c("87195186bffffff", "871951b36ffffff")

  # Act
  coords <- h3_to_geo(indexes)

  # Assert
  expect_is(coords, "matrix")
  expect_equal(colnames(coords), c("lat", "lng"))
  expect_length(coords, 4)
})
