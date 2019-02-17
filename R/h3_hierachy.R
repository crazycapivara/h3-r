#' Get the parent of the given hexagon at a particular resolution.
#' @param h3_index character scalar representing a valid H3 index
#' @param res resolution of parent
#' @return character scalar
#' @export
h3_to_parent <- function(h3_index, res) {
  rcpp_h3_to_parent(h3_index, res)
}

#' Get the children of the given hexagon at a particular resolution.
#' @inheritParams h3_to_parent
#' @param res resolution of children
#' @return character vector
#' @export
h3_to_children <- function(h3_index, res) {
  rcpp_h3_to_children(h3_index, res)
}
