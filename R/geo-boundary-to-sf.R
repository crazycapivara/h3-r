make_polygon <- function(latlng) {
  lnglat_closed <- rbind(latlng, latlng[1, ])[, 2:1]
  sf::st_polygon(list(lnglat_closed))
}

make_sf <- function(polygons) {
  sf::st_sfc(polygons, crs = 4326) %>%
    sf::st_sf()
}

#' Parse geo boundaries to object of class \code{sf}
#' @param latlng geo coordinates
#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf <- function(latlng) {
  UseMethod("geo_boundary_to_sf")
}

#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf.matrix <- function(latlng) {
  make_polygon(latlng) %>% make_sf()
}

#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf.list <- function(latlng) {
  lapply(latlng, make_polygon) %>% make_sf()
}
