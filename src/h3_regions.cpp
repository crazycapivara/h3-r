#include <Rcpp.h>
#include <h3/h3api.h>

#include "h3_indexing.h"

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector rcpp_polyfill(NumericMatrix coords, int res) {
  // Make geofence
  Geofence geofence;
  int n = coords.nrow();
  geofence.numVerts = n;
  GeoCoord* sfVerts = new GeoCoord[n];
  for (int i = 0; i < n; i++) {
    GeoCoord coord;
    coord.lon = degsToRads( mercatorLng( coords(i, 0) ) );
    coord.lat = degsToRads( mercatorLat( coords(i, 1) ) );
    sfVerts[i] = coord;
  }

  geofence.verts = sfVerts;

  // Make polygon
  GeoPolygon polygon;
  polygon.geofence = geofence;
  polygon.numHoles = 0;

  int numHexagons = H3_EXPORT(maxPolyfillSize)(&polygon, res);
  H3Index* hexagons = new H3Index[numHexagons]();
  H3_EXPORT(polyfill)(&polygon, res, hexagons);
  CharacterVector z(numHexagons);
  for (int i = 0; i < numHexagons; i++) {
    H3Index hexagon = hexagons[i];
    if (hexagon != 0) {
      char h3Str[17];
      h3ToString(hexagons[i], h3Str, sizeof(h3Str));
      z[i] = h3Str;
    }
  }

  /*
  CharacterVector z(3);
  z[0] = "Hi Folks";
  z[1] = geofence.numVerts;
  z[2] = numHexagons;
  */

  delete[] hexagons;
  return z;
}
