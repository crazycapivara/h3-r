polyfill_ <- function(polygon, res = 7) {
  x <- rcpp_polyfill(polygon, res)
  x[x != ""]
}

#' Get all hexagons with centers contained in a given polygon.
#' @param polygon geo-coordinates of polygon as lng/lat pairs (matrix) or object of class \code{sf}
#'   or \code{sfc}
#' @inheritParams geo_to_h3
#' @return character vector of H3 indexes
#' @example inst/examples/api-reference/polyfill.R
#' @export
polyfill <- function(polygon, res = 7) {
  UseMethod("polyfill", polygon)
}

#' @name polyfill
#' @export
polyfill.matrix <- function(polygon, res = 7) {
  polyfill_(polygon, res)
}

#' @name polyfill
#' @export
polyfill.sfc <- function(polygon, res = 7) {
  lnglat <- c("X", "Y")
  sf::st_coordinates(polygon[1])[, lnglat] %>%
    polyfill(res)
}

#' @name polyfill
#' @export
polyfill.sf <- function(polygon, res = 7) {
  sf::st_geometry(polygon) %>%
    polyfill(res)
}
