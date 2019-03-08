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

test_that("is res class III", {
  # Prepare
  indexes_res_0 <- road_safety_greater_manchester[1, ] %>%
    geo_to_h3(0) %>%
    k_ring()
  indexes_res_1 <- road_safety_greater_manchester[1, ] %>%
    geo_to_h3(1) %>%
    k_ring()

  # Act
  is_res_class_iii_0 <- h3_is_res_class_iii(indexes_res_0)
  is_res_class_iii_1 <- h3_is_res_class_iii(indexes_res_1)

  # Assert
  expect_false(all(is_res_class_iii_0))
  expect_true(all(is_res_class_iii_1))
})
