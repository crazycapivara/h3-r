#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

//' Number of unique H3 indexes at the given resolution.
//' @param res numeric vector; resolution between 0 and 15
//' @return numeric vector
//' @export
// [[Rcpp::export]]
NumericVector num_hexagons(NumericVector res) {
  int n = res.size();
  NumericVector z(n);
  for (int i; i < n; ++i) {
    z[i] = numHexagons(res[i]);
  }

  return z;
}
