edges <- road_safety_greater_manchester[1, ] %>%
  geo_to_h3() %>%
  get_h3_unidirectional_edges_from_hexagon()

h3_unidirectional_edge_is_valid(edges)
