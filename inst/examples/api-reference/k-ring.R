road_safety_greater_manchester[1, ] %>%
  geo_to_h3() %>%
  k_ring() %>%
  h3_to_geo_boundary_sf() %>%
  sf::st_geometry() %>%
  plot(col = "blue")
