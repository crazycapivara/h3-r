#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

//' Check whether the given hexagons are neighbors.
//' @param origin character scalar; origin H3 index
//' @param destinations character vector of destination H3 indexes
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

//' Get the H3 edge index based on the given origin and destination hexagons.
//' @param origin character scalar; origin H3 index
//' @param destination character scalar; destination H3 index
//' @export
// [[Rcpp::export]]
CharacterVector get_h3_unidirectional_edge(String origin, String destination) {
  H3Index h3Origin = H3_EXPORT(stringToH3)(origin.get_cstring());
  H3Index h3Destination = H3_EXPORT(stringToH3)(destination.get_cstring());
  H3Index h3Edge = H3_EXPORT(getH3UnidirectionalEdge)(h3Origin, h3Destination);
  char edgeIndexStr[17];
  H3_EXPORT(h3ToString)(h3Edge, edgeIndexStr, sizeof(edgeIndexStr));
  CharacterVector z(1);
  z[0] = edgeIndexStr;
  return z;
}

//' Check whether the given indexes are valid H3 edge indexes.
//' @param h3_edge_indexes character vector of H3 edge indexes
//' @export
// [[Rcpp::export]]
LogicalVector h3_unidirectional_edge_is_valid(CharacterVector h3_edge_indexes) {
  int n = h3_edge_indexes.size();
  LogicalVector z(n);
  for (int i = 0; i < n; i++) {
    H3Index h3EdgeIndex = H3_EXPORT(stringToH3)(h3_edge_indexes[i]);
    z[i] = H3_EXPORT(h3UnidirectionalEdgeIsValid)(h3EdgeIndex);
  }
  return z;
}

// [[Rcpp::export]]
NumericMatrix rcpp_get_h3_unidirectional_edge_boundary(String h3EdgeStr) {
  H3Index h3EdgeIndex = stringToH3(h3EdgeStr.get_cstring());
  GeoBoundary geoBoundary;
  H3_EXPORT(getH3UnidirectionalEdgeBoundary)(h3EdgeIndex, &geoBoundary);
  NumericMatrix m(geoBoundary.numVerts, 2);
  for (int i = 0; i < geoBoundary.numVerts; i++) {
    m(i, 0) = radsToDegs(geoBoundary.verts[i].lat);
    m(i, 1) = radsToDegs(geoBoundary.verts[i].lon);
  }

  colnames(m) = CharacterVector::create("lat", "lng");
  return m;
}

// [[Rcpp::export]]
CharacterVector rcpp_get_h3_unidirectional_edges_from_hexagon(String originStr) {
  H3Index origin = stringToH3(originStr.get_cstring());
  const int n = 6;
  H3Index* edges = new H3Index[n]();
  getH3UnidirectionalEdgesFromHexagon(origin, edges);
  int counter = 0;
  for (int i = 0; i< n; i++) {
    if (edges[i] != 0) counter++;
  }

  CharacterVector z(counter);
  for (int i = 0; i < counter; i++) {
    char edgeStr[17];
    h3ToString(edges[i], edgeStr, sizeof(edgeStr));
    z[i] = edgeStr;
  }

  return z;
}

// [[Rcpp::export]]
String rcpp_get_origin_h3_index_from_unidirectional_edge(String h3EdgeStr) {
  H3Index h3EdgeIndex = stringToH3(h3EdgeStr.get_cstring());
  H3Index h3OriginIndex = getOriginH3IndexFromUnidirectionalEdge(h3EdgeIndex);
  char h3OriginStr[17];
  h3ToString(h3OriginIndex, h3OriginStr, sizeof(h3OriginStr));
  return h3OriginStr;
}

// [[Rcpp::export]]
String rcpp_get_destination_h3_index_from_unidirectional_edge(String h3EdgeStr) {
  H3Index h3EdgeIndex = stringToH3(h3EdgeStr.get_cstring());
  H3Index h3DestinationIndex = getDestinationH3IndexFromUnidirectionalEdge(h3EdgeIndex);
  char h3DestinationStr[17];
  h3ToString(h3DestinationIndex, h3DestinationStr, sizeof(h3DestinationStr));
  return h3DestinationStr;
}
