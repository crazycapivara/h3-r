context("inspection")

test_that("is pentagon", {
  # Prepare
  all_indexes <- road_safety_greater_manchester[1, ] %>%
    geo_to_h3(0) %>%
    k_ring(10)

  # Act
  is_pentagon <- h3_is_pentagon(all_indexes)

  # Assert
  expect_length(is_pentagon, 122)
  expect_equal(sum(is_pentagon), 8)
})
