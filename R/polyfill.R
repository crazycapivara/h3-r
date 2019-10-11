#' @export
polyfill <- function(polygon, res = 7) {
  x <- rcpp_polyfill(polygon, res)
  x[x != ""]
}
