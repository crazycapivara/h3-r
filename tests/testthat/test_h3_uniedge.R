context("H3 uni edge")

test_that("get edge index", {
  # Prepare
  h3_origin <- "87283472bffffff"
  h3_destinations <- c(
    "87283472affffff", "87283470cffffff", "87283470dffffff",
    "872834776ffffff", "872834729ffffff", "872834728ffffff"
  )

  # Act
  h3_edge_index <- get_h3_unidirectional_edge(h3_origin, h3_destinations[1])

  # Assert
  expect_equal(h3_edge_index, "167283472bffffff")
})
