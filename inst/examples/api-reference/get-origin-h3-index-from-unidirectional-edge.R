h3_index <- road_safety_greater_manchester[1, ] %>%
  geo_to_h3()

edges <- get_h3_unidirectional_edges_from_hexagon(h3_index)
get_origin_h3_index_from_unidirectional_edge(edges[1]) == h3_index
