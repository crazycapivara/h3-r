#' @export
geo_to_h3 <- function(latlng, res) {
  UseMethod("geo_to_h3")
}

#' @export
geo_to_h3.numeric <- function(latlng, res = 7) {
  matrix(latlng, ncol = 2) %>% rcpp_geo_to_h3(res)
}

#' @export
geo_to_h3.matrix <- function(latlng, res = 7) {
  rcpp_geo_to_h3(latlng, res)
}

#' @export
geo_to_h3.sf <- function(latlng, res = 7) {
  sf::st_coordinates(latlng)[, 2:1] %>% rcpp_geo_to_h3(res)
}

#' @export
h3_to_geo_boundary_sf <- function(h3index) {
  rcpp_h3_to_geo_boundary(h3index) %>%
    geo_boundary_to_sf()
}
