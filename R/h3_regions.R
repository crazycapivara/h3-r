#' Create a (multi) polygon describing the outline(s) of a set of hexagons.
#' @param h3_indexes character vector of H3 indexes
#' @return \code{sf} object; \code{POLYGON} (if only one outline is created) or \code{MULTIPOLYGON}
#' @export
h3_set_to_multi_polygon <- function(h3_indexes) {
  h3_to_geo_boundary_sf(h3_indexes) %>%
    sf::st_union()
}
