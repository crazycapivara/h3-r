#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector rcpp_h3_to_parent(String h3s, int res) {
  CharacterVector z(1);
  H3Index h3 = stringToH3(h3s.get_cstring());
  H3Index h3Parent = h3ToParent(h3, res);
  char h3ParentStr[17];
  h3ToString(h3Parent, h3ParentStr, sizeof(h3ParentStr));
  z[0] = h3ParentStr;
  return z;
}

// [[Rcpp::export]]
CharacterVector rcpp_h3_to_children(String h3s, int res) {
  H3Index h3 = stringToH3(h3s.get_cstring());
  int n = maxH3ToChildrenSize(h3, res);
  // H3Index h3Children[n];
  H3Index* h3Children = new H3Index[n];
  h3ToChildren(h3, res, h3Children);
  CharacterVector z(n);
  for (int i = 0; i < n; ++i) {
    char childStr[17];
    h3ToString(h3Children[i], childStr, sizeof(childStr));
    z[i] = childStr;
  }

  delete[] h3Children;
  return z;
}

// [[Rcpp::export]]
CharacterVector rcpp_compact(CharacterVector h3Str) {
  int n = h3Str.size();
  H3Index* input = new H3Index[n];
  for (int i = 0; i < n; ++i) {
    H3Index h3 = stringToH3(h3Str[i]);
    input[i] = h3;
  }

  H3Index* compacted = new H3Index[n]();
  int err = compact(input, compacted, n);
  int compactCounter = 0;
  for (int i = 0; i < n; ++i) {
    if (compacted[i] != 0) {
      compactCounter++;
    }
  }

  CharacterVector z(compactCounter);
  for (int i = 0; i < compactCounter; ++i) {
    char compactedStr[17];
    h3ToString(compacted[i], compactedStr, sizeof(compactedStr));
    z[i] = compactedStr;
  }

  delete[] input;
  delete[] compacted;
  return z;
}
