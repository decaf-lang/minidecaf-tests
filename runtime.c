#include "runtime.h"

#include <time.h>

int rng_state = 1;

int init() {
  rng_state = time(NULL);
  return 0;
}

int read_arg_reg_8(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                   int a7) {
  // we no longer impose restrictions on the use of registers
  // writing assembly manually is painful :(
  return hash(hash(hash(a0, a1), hash(a2, a3)),
              hash(hash(a4, a5), hash(a6, a7)));
}

int read_arg_reg_16(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                    int a7, int a8, int a9, int a10, int a11, int a12, int a13,
                    int a14, int a15) {
  // we no longer impose restrictions on the use of registers
  // writing assembly manually is painful :(
  return hash(
      hash(hash(hash(a0, a1), hash(a2, a3)), hash(hash(a4, a5), hash(a6, a7))),
      hash(hash(hash(a8, a9), hash(a10, a11)),
           hash(hash(a12, a13), hash(a14, a15))));
}

int fill_n(int a[], int n, int v) {
  for (int i = 0; i < n; ++i) {
    a[i] = v;
  }
  return 0;
}
