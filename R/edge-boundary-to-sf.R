#' Parse edge coordiantes to \code{sf} object
#' @param latlng matrix (2x2); edge coordinates
#' @export
edge_boundary_to_sf <- function(latlng) {
  sf::st_linestring(latlng[, 2:1]) %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf()
}

#' Get the unidirectional edge as \code{sf} object.
#' @inheritParams get_h3_unidirectional_edge_boundary
#' @export
get_h3_unidirectional_edge_boundary_sf <- function(h3_edge_index) {
  get_h3_unidirectional_edge_boundary(h3_edge_index) %>%
    edge_boundary_to_sf()
}
