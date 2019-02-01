#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

//' Get the resolution of the given H3 indexes.
//' @param h3Str character vector of H3 indexes
//' @return numeric vector
//' @export
// [[Rcpp::export]]
NumericVector h3_get_resolution(CharacterVector h3Str) {
  int n = h3Str.size();
  NumericVector z(n);
  for (int i = 0; i < n; ++i) {
    H3Index h3 = stringToH3(h3Str[i]);
    z[i] = h3GetResolution(h3);
  }

  return z;
}

//' Check whether the given H3 indexes are valid.
//' @param h3Str character vector of H3 indexes
//' @return logical vector
//' @export
// [[Rcpp::export]]
LogicalVector h3_is_valid(CharacterVector h3Str) {
  int n = h3Str.size();
  LogicalVector z(n);
  for (int i = 0; i < n; ++i) {
    H3Index h3 = stringToH3(h3Str[i]);
    z[i] = h3IsValid(h3);
  }

  return z;
}

//' Get the base cells of the given H3 indexes.
//' @param h3Str character vector of H3 indexes
//' @return numeric vector; base cell numbers between 0 and 121
//' @export
// [[Rcpp::export]]
NumericVector h3_get_base_cell(CharacterVector h3Str) {
  int n = h3Str.size();
  NumericVector z(n);
  for (int i = 0; i < n; ++i) {
    H3Index h3 = stringToH3(h3Str[i]);
    z[i] = h3GetBaseCell(h3);
  }

  return z;
}
