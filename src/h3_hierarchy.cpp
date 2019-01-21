#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

// H3Index h3ToParent(H3Index h, int parentRes);
//' @export
// [[Rcpp::export]]
CharacterVector h3_to_parent(String h3s, int res) {
  CharacterVector z(1);
  H3Index h3 = stringToH3(h3s.get_cstring());
  H3Index h3Parent = h3ToParent(h3, res);
  char h3Parent_str[17];
  h3ToString(h3Parent, h3Parent_str, sizeof(h3Parent_str));
  z[0] = h3Parent_str;
  return z;
}

// void h3ToChildren(H3Index h, int childRes, H3Index *children);
//' @export
// [[Rcpp::export]]
CharacterVector h3_to_children(String h3s, int res) {
  H3Index h3 = stringToH3(h3s.get_cstring());
  int n = maxH3ToChildrenSize(h3, res);
  H3Index children[n];
  h3ToChildren(h3, res, children);
  CharacterVector z(n);
  for (int i = 0; i < n; ++i) {
    char child_str[17];
    h3ToString(children[i], child_str, sizeof(child_str));
    z[i] = child_str;
  }

  return z;
}
