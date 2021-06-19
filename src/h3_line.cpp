#include <Rcpp.h>
// #include <h3/h3api.h>
#include "h3api.h"

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector rcpp_h3_line(String startStr, String endStr) {
  H3Index h3Start = stringToH3(startStr.get_cstring());
  H3Index h3End = stringToH3(endStr.get_cstring());
  int n = h3LineSize(h3Start, h3End);
  H3Index* out = new H3Index[n]();
  h3Line(h3Start, h3End, out);
  CharacterVector z(n);
  for (int i = 0; i < n; i++) {
    char h3Str[17];
    h3ToString(out[i], h3Str, sizeof(h3Str));
    z[i] = h3Str;
  }

  delete[] out;
  return z;
}

