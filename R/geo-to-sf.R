#' Parse centers / geo-coordinates to \code{sf} object.
#' @param latlng geo-coordinates
#' @name geo_to_sf
#' @export
geo_to_sf <- function(latlng) {
  UseMethod("geo_to_sf")
}

#' @name geo_to_sf
#' @export
geo_to_sf.matrix <- function(latlng) {
  as.data.frame(latlng) %>%
    sf::st_as_sf(coords = 2:1, crs = 4326)
}
