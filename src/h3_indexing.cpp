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

// [[Rcpp::export]]
CharacterVector rcpp_geo_to_h3(NumericMatrix latlng, int res) {
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

// [[Rcpp::export]]
NumericMatrix rcpp_h3_to_geo(CharacterVector h3s) {
  int n = h3s.size();
  NumericMatrix m(n, 2);
  for (int i = 0; i < n; ++i) {
    uint64_t h3 = stringToH3(h3s[i]);
    GeoCoord geoCoord;
    h3ToGeo(h3, &geoCoord);
    m(i, 0) = radsToDegs(geoCoord.lat);
    m(i, 1) = radsToDegs(geoCoord.lon);
  }

  colnames(m) = CharacterVector::create("lat", "lng");
  return m;
}

NumericMatrix rcpp_h3_to_geo_boundary(String h3s) {
  uint64_t h3 = stringToH3(h3s.get_cstring());
  GeoBoundary geoBoundary;
  h3ToGeoBoundary(h3, &geoBoundary);
  NumericMatrix m(geoBoundary.numVerts, 2);
  for (int i = 0; i < geoBoundary.numVerts; ++i) {
    m(i, 0) = radsToDegs(geoBoundary.verts[i].lat);
    m(i, 1) = radsToDegs(geoBoundary.verts[i].lon);
  }

  colnames(m) = CharacterVector::create("lat", "lng");
  return m;
}

// [[Rcpp::export]]
List rcpp_h3_to_geo_boundary(CharacterVector h3s) {
  int n = h3s.size();
  List z(n);
  for (int i = 0; i < n; ++i) {
    z[i] = rcpp_h3_to_geo_boundary(h3s[i]);
  }

  return z;
}
