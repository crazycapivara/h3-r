context("H3 hierachy")

test_that("parent", {
  # Prepare
  idx <- "87283472bffffff"

  # Act
  parent <- h3_to_parent(idx, 6)
  no_parent <- h3_to_parent(idx, 8)

  # Assert
  expect_equal(parent, "86283472fffffff")
  expect_equal(no_parent, "0")
})

test_that("children", {
  # Prepare
  idx <- "86283472fffffff"

  # Act
  children <- h3_to_children(idx, 7)
  no_children <- h3_to_children(idx, 5)

  # Assert
  expect_length(children, 7)
  expect_length(no_children, 0)
})
