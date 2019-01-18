#' Index geo-coordinates at the given resolution into H3 addresses.
#' @param latlng geo-coordinates as lat/lng pairs or object of class \code{sf}
#' @param res resolution between 0 and 15
#' @return character vector
#' @name geo_to_h3
#' @export
geo_to_h3 <- function(latlng, res) {
  UseMethod("geo_to_h3")
}

#' @name geo_to_h3
#' @export
geo_to_h3.numeric <- function(latlng, res = 7) {
  matrix(latlng, ncol = 2) %>% rcpp_geo_to_h3(res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.matrix <- function(latlng, res = 7) {
  rcpp_geo_to_h3(latlng, res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.data.frame <- function(latlng, res = 7) {
  as.matrix(latlng) %>% rcpp_geo_to_h3(res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.sf <- function(latlng, res = 7) {
  sf::st_coordinates(latlng)[, 2:1] %>% rcpp_geo_to_h3(res)
}

#' Get the centers of the given H3 indexes.
#' @param h3_index character vector of H3 indexes
#' @export
h3_to_geo <- function(h3_index) {
  rcpp_h3_to_geo(h3_index)
}

#' Get the centers of the given H3 indexes as \code{sf} object.
#' @inheritParams h3_to_geo
#' @export
h3_to_geo_sf <- function(h3_index) {
  rcpp_h3_to_geo(h3_index) %>%
    geo_to_sf()
}

#' Get the vertices of the given H3 indexes.
#' @inheritParams h3_to_geo
#' @return list of matrices with geo-coordinates as lat/lng pairs for each H3 index
#' @export
h3_to_geo_boundary <- function(h3_index) {
  rcpp_h3_to_geo_boundary(h3_index)
}

#' Get the polygons of the given H3 indexes as \code{sf} object.
#' @param h3_index character vector of H3 indexes
#' @return object of class \code{sf}
#' @export
h3_to_geo_boundary_sf <- function(h3_index) {
  rcpp_h3_to_geo_boundary(h3_index) %>%
    geo_boundary_to_sf()
}
