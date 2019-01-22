#' Get the parent of the given hexagon at a particular resolution.
#' @inheritParams h3_to_geo
#' @param res resolution of parent
#' @return character
#' @export
h3_to_parent <- function(h3_index, res) {
  rcpp_h3_to_parent(h3_index, res)
}

#' Get the children of the given hexagon at a particular resolution.
#' @inheritParams h3_to_geo
#' @param res resolution of children
#' @return character
#' @export
h3_to_children <- function(h3_index, res) {
  rcpp_h3_to_children(h3_index, res)
}
