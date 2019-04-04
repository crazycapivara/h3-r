context("H3 traversal")

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

test_that("k ring distances", {
  # Prepare
  h3_index <- "87283472bffffff"
  radius <- 2

  # Act
  neighbors <- k_ring_distances(h3_index, radius)

  # Assert
  expect_is(neighbors, "tbl")
  expect_equal(unique(neighbors$distance), 0:2)
  expect_length(neighbors$h3_index, 19)
})

test_that("hex ring", {
  # Prepare
  h3_index <- "87283472bffffff"
  radius <- 2

  # Act
  indexes <- hex_ring(h3_index, radius)
  distances <- h3_distance(h3_index, indexes)

  # Assert
  expect_length(indexes, 12)
  expect_true(all(distances == 2))
})

test_that("h3 line", {
  # Prepare
  origin <- "8710887b4ffffff"
  destination <- "871088473ffffff"

  # Act
  line_indexes <- h3_line(origin, destination)

  # Assert
  line_expected <- c(
    "8710887b4ffffff", "87108845affffff", "87108845effffff",
    "871088451ffffff", "871088455ffffff", "871088473ffffff"
  )

  expect_is(line_indexes, "character")
  expect_length(line_indexes, 6)
  expect_equal(line_indexes, line_expected)
})
