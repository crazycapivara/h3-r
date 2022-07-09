polyfill_ <- function(polygon, res = 7) {
  x <- rcpp_polyfill(polygon, res)
  x[x != ""]
}

#' Get all hexagons with centers contained in a given polygon.
#' @param polygon geo-coordinates of polygon as lat/lng pairs (matrix) or object of class \code{sf}
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
polyfill.sfc_POLYGON <- function(polygon, res = 7) {
  if (sfc_polygon_has_holes(polygon)) {
    message("polygon has holes")
    return(polyfill_sfc_polygon_with_holes(polygon, res))
  }

  latlng <- c("Y", "X")
  sf::st_coordinates(polygon[1])[, latlng] %>%
    polyfill(res)
}

#' @name polyfill
#' @export
polyfill.sfc_MULTIPOLYGON <- function(polygon, res = 7) {
  polygon[1] %>%
    sf::st_cast("POLYGON") %>%
    purrr::map(~ polyfill(sf::st_geometry(.x), res)) %>%
    unlist()
}

#' @name polyfill
#' @export
polyfill.sf <- function(polygon, res = 7) {
  sf::st_geometry(polygon) %>%
    polyfill(res)
}

sfc_polygon_has_holes <- function(polygon) {
  length(unique(st_coordinates(polygon)[, "L1"])) > 1
}

polyfill_sfc_polygon_with_holes <- function(polygon, res = 7) {
  polygon_without_holes <- sfheaders::sf_remove_holes(polygon)
  holes <- sf::st_difference(polygon_without_holes, polygon)
  h3_idx <- polyfill(polygon_without_holes, res = res)
  h3_idx_holes <- polyfill(holes, res = res)
  h3_idx[!(h3_idx %in% h3_idx_holes)]
}
