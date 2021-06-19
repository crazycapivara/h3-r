#include <Rcpp.h>
// #include <h3/h3api.h>
#include "h3api.h"

using namespace Rcpp;

//' Number of unique H3 indexes at the given resolution.
//' @param res numeric vector; resolution between 0 and 15
//' @return numeric vector
//' @export
// [[Rcpp::export]]
NumericVector num_hexagons(NumericVector res) {
  int n = res.size();
  NumericVector z(n);
  for (int i = 0; i < n; ++i) {
    z[i] = numHexagons(res[i]);
  }

  return z;
}

//' Average hexagon area in square meters or kilometers at the given resolution.
//' @param res resolution between 0 and 15
//' @param unit either \code{m2} or \code{km2}
//' @return numeric vector
//' @export
// [[Rcpp::export]]
NumericVector hex_area(NumericVector res, String unit) {
  int n = res.size();
  NumericVector z(n);
  for (int i = 0; i < n; ++i) {
    z[i] = (unit == "m2") ? hexAreaM2(res[i]) : hexAreaKm2(res[i]);
  }

  return z;
}

//' Average hexagon edge length in meters or kilometers at the given resolution.
//' @param res resolution between 0 and 15
//' @param unit either \code{m} or \code{km}
//' @return numeric vector
//' @export
// [[Rcpp::export]]
NumericVector edge_length(NumericVector res, String unit) {
  int n = res.size();
  NumericVector z(n);
  for (int i = 0; i < n; ++i) {
    z[i] = (unit == "m") ? edgeLengthM(res[i]) : edgeLengthKm(res[i]);
  }

  return z;
}

