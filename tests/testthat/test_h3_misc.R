context("H3 misc")

test_that("num hexagons", {
  # Prepare
  resolutions <- 1:4

  # Act
  n <- num_hexagons(resolutions)

  # Assert
  expect_length(n, 4)
  expect_equal(n, c(842, 5882, 41162, 288122))
})
