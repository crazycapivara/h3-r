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

test_that("get all edges from hexagon", {
  # Prepare
  index <- "87283472bffffff"

  # Act
  edge_indexes <- get_h3_unidirectional_edges_from_hexagon(index)

  # Assert
  expected_edges <- c("117283472bffffff", "127283472bffffff", "137283472bffffff",
                      "147283472bffffff", "157283472bffffff", "167283472bffffff")
  expect_length(edge_indexes, 6)
  expect_equal(edge_indexes, expected_edges)
})

test_that("edge boundary", {
  # Prepare
  edge_index <- "117195186bffffff"

  # Act
  coords <- get_h3_unidirectional_edge_boundary(edge_index)
  coords_dim <- dim(coords)
  coord_colnames <- colnames(coords)

  # Assert
  expect_true(h3_unidirectional_edge_is_valid(edge_index))

  expect_is(coords, "matrix")
  expect_equal(coords_dim, c(2, 2))
  expect_equal(coord_colnames, c("lat", "lng"))
})

test_that("parse edge index to sf object", {
  # Prepare
  edge_index <- "117195186bffffff"

  # Act
  line <- get_h3_unidirectional_edge_boundary_sf(edge_index)

  # Assert
  expect_true(h3_unidirectional_edge_is_valid(edge_index))

  expect_equal(sf::st_crs(line)$epsg, 4326)
  expect_is(line, "sf")
  expect_length(nrow(line), 1)
})

test_that("get origin from edge", {
  # Prepare
  h3_edge_index <- "117195186bffffff"

  # Act
  h3_index <- get_origin_h3_index_from_unidirectional_edge(h3_edge_index)
  is_valid_h3_index <- h3_is_valid(h3_index)

  # Assert
  expect_true(is_valid_h3_index)
  expect_equal(h3_index, "87195186bffffff")
})

test_that("get destination from edge", {
  # Prepare
  h3_orgin_index <- "87195186bffffff"
  h3_destination_index <- "871951b36ffffff"

  # Act
  are_neighbors <- h3_indexes_are_neighbors(h3_orgin_index, h3_destination_index)
  edge <- get_h3_unidirectional_edge(h3_orgin_index, h3_destination_index)
  destination <- get_destination_h3_index_from_unidirectional_edge(edge)

  # Assert
  expect_true(are_neighbors)
  expect_equal(destination, h3_destination_index)
})
