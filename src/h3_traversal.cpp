#include <malloc.h>
#include <Rcpp.h>
#include <h3/h3api.h>

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector rcpp_k_ring(String h3s, int radius) {
  H3Index h3 = stringToH3(h3s.get_cstring());
  int n = maxKringSize(radius);
  H3Index* out = (H3Index*)calloc(n, sizeof(H3Index));
  kRing(h3, radius, out);
  int counter = 0;
  for (int i = 0; i < n; ++i) {
    if (out[i] != 0) {
      ++counter;
    }
  }

  CharacterVector z(counter);
  for(int i = 0; i < counter; ++i) {
    char h3s[17];
    h3ToString(out[i], h3s, sizeof(h3s));
    z[i] = h3s;
  }

  free(out);
  return z;
}

// use 'lapply' in R
List rcpp_k_ring(StringVector h3s, int radius) {
  int n = h3s.size();
  List z(n);
  for (int i = 0; i < n; ++i) {
    z[i] = rcpp_k_ring(h3s[i], radius);
  }

  return z;
}