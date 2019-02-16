context("traversal")

test_that("k ring", {
  # Prepare
  h3_index <- "87283472bffffff"

  # Act
  neighbors <- k_ring(h3_index)

  # Assert
  expected_neighbors <- c(
    "87283472bffffff", "87283472affffff", "87283470cffffff",
    "87283470dffffff", "872834776ffffff", "872834729ffffff",
    "872834728ffffff"
  )
  expect_length(neighbors, 7)
  expect_equal(neighbors, expected_neighbors)
})
