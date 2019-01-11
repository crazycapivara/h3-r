#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

//' @export
// [[Rcpp::export]]
CharacterVector geo_to_h3(NumericMatrix latlng, int res) {
  int n = latlng.nrow();
  CharacterVector z(n);
  for (int i = 0; i < n; ++i) {
    GeoCoord location;
    location.lat = degsToRads(latlng(i, 0));
    location.lon = degsToRads(latlng(i, 1));
    H3Index h3 = geoToH3(&location, res);
    char h3s[17];
    h3ToString(h3, h3s, sizeof(h3s));
    z[i] = h3s;
  }

  return z;
}
