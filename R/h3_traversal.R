#' Get all hexagons in a k-ring around the given center.
#' @note The order of the hexagons is undefined.
#' @inheritParams h3_to_geo
#' @param radius number of rings around the given center
#' @return character vector of H3 indexes
#' @export
k_ring <- function(h3_index, radius = 1) {
  rcpp_k_ring(h3_index, radius)
}
