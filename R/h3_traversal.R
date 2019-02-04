#' Get all hexagons in a k-ring around the given center.
#' @note The order of the hexagons is undefined.
#' @inheritParams h3_to_geo
#' @param radius number of rings around the given center
#' @return character vector of H3 indexes
#' @example inst/examples/api-reference/k-ring.R
#' @export
k_ring <- function(h3_index, radius = 1) {
  rcpp_k_ring(h3_index, radius)
}

#' Get all hexagons in a k-ring around a given center ordered by distance from the origin.
#' @note The order of the hexagons within each ring is undefined.
#' @inheritParams k_ring
#' @return tibble with 2 variables: \code{h3_index} and \code{distance}
#' @export
k_ring_distances <- function(h3_index, radius = 1) {
  out <- rcpp_k_ring_distances(h3_index, radius)
  tibble::tibble(h3_index = out[[1]], distance = out[[2]])
}
