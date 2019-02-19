#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

//' Check whether the given hexagons are neighbors.
//' @param origin character scalar; origin H3 index
//' @param destinations; character vector of destination H3 indexes
//' @export
// [[Rcpp::export]]
LogicalVector h3_indexes_are_neighbors(String origin, CharacterVector destinations) {
  int n = destinations.size();
  H3Index h3Origin = stringToH3(origin.get_cstring());
  LogicalVector z(n);
  for (int i = 0; i < n; i++) {
    H3Index h3Destination = stringToH3(destinations[i]);
    z[i] = H3_EXPORT(h3IndexesAreNeighbors)(h3Origin, h3Destination) == 1 ? true : false;
  }

  return z;
}

