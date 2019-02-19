#' Parse edge coordiantes to \code{sf} object
#' @param latlng matrix; edge coordinates
#' @export
edge_boundary_to_sf <- function(latlng) {
  sf::st_linestring(latlng[, 2:1]) %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf()
}

get_h3_unidirectional_edge_boundary_sf <- function(h3_edge_index) {
  "Not implemented yet"
}
