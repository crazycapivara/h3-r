context("H3 uni edge")

# Prepare
h3_origin <- "87283472bffffff"
h3_destinations <- c(
  "87283472affffff", "87283470cffffff", "87283470dffffff",
  "872834776ffffff", "872834729ffffff", "872834728ffffff"
)

test_that("get edge index", {
  # Act
  h3_edge_index <- get_h3_unidirectional_edge(h3_origin, h3_destinations[1])

  # Assert
  expect_equal(h3_edge_index, "167283472bffffff")
})

test_that("neighbors", {
  # Prepare
  destinations <- c(h3_origin, h3_destinations)

  # Act
  are_neighbors <- h3_indexes_are_neighbors(h3_origin, destinations)

  # Assert
  expect_length(are_neighbors, 7)
  expect_equal(are_neighbors, c(FALSE, rep(TRUE, 6)))
})

test_that("edge index is valid", {
  # Prepare
  indexes <- c("167283472bffffff", h3_origin)

  # Act
  are_valid <- h3_unidirectional_edge_is_valid(indexes)

  # Assert
  expect_length(are_valid, 2)
  expect_equal(are_valid, c(TRUE, FALSE))
})
