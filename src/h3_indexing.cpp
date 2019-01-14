#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

// Helper coerce lat range
double mercatorLat(double lat) {
  if (lat > 90) {
    return lat - 180;
  }

  return lat;
}

// Helper coerce lng range
double mercatorLng(double lng) {
  if (lng > 180) {
    return lng - 360;
  }

  return lng;
}

//' @export
// [[Rcpp::export]]
CharacterVector geo_to_h3(NumericMatrix latlng, int res) {
  int n = latlng.nrow();
  CharacterVector z(n);
  for (int i = 0; i < n; ++i) {
    GeoCoord location;
    location.lat = degsToRads(mercatorLat(latlng(i, 0)));
    location.lon = degsToRads(mercatorLng(latlng(i, 1)));
    H3Index h3 = geoToH3(&location, res);
    char h3s[17];
    h3ToString(h3, h3s, sizeof(h3s));
    z[i] = h3s;
  }

  return z;
}
