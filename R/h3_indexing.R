#' @export
h3_to_geo_boundary_sf <- function(h3index) {
  rcpp_h3_to_geo_boundary(h3index) %>%
    geo_boundary_to_sf()
}
