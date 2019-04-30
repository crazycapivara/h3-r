#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector rcpp_hex_ring(String h3s, int radius) {
  H3Index h3 = stringToH3(h3s.get_cstring());
  int n = maxKringSize(radius);
  H3Index* out = new H3Index[n]();
  hexRing(h3, radius, out);
  int counter = 0;
  for (int i = 0; i < n; i++) {
    if (out[i] != 0) {
      counter++;
    }
  }

  CharacterVector z(counter);
  for(int i = 0; i < counter; i++) {
    char h3s[17];
    h3ToString(out[i], h3s, sizeof(h3s));
    z[i] = h3s;
  }

  // free(out);
  delete[] out;
  return z;
}

