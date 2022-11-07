// declared in runtime.h
int random();
int hash(int x, int y);
int clear_caller_saved_registers();
int init();

int check(int seed, int flag) {
  // linear congruential generator
  int a0 = seed % 32717;
  int a1 = a0 * 32715 % 32717;
  int a2 = a1 * 32715 % 32717;
  int a3 = a2 * 32715 % 32717;

  // Fourier transform on F_32717
  int b0 = a0;
  int b1 = a2;
  int b2 = a1;
  int b3 = a3;

  int c0 = (b0 + b1) % 32717;
  int c1 = (b0 - b1 + 32717) % 32717;
  int c2 = (b2 + b3) % 32717;
  int c3 = (b2 - b3 + 32717) % 32717;

  int d0 = (c0 + c2) % 32717;
  int d1 = (c1 + 11332 * c3 % 32717) % 32717;
  int d2 = (c0 - c2 + 32717) % 32717;
  int d3 = (c1 - 11332 * c3 % 32717 + 32717) % 32717;

  int e0 = d0 * 16359 % 32717;
  int e1 = d1 * 16359 % 32717;
  int e2 = d2 * 16359 % 32717;
  int e3 = d3 * 16359 % 32717;

  // all caller saved registers should be occupied
  if (flag != 0) {
    clear_caller_saved_registers();
  }

  return hash(
      hash(hash(hash(b0, b1), hash(b2, b3)), hash(hash(c0, c1), hash(c2, c3))),
      hash(hash(hash(d0, d1), hash(d2, d3)), hash(hash(e0, e1), hash(e2, e3))));
}

int main() {
  init();
  for (int i = 0; i < 100; i = i + 1) {
    int seed = random();
    if (check(seed, 0) != check(seed, !0)) {
      return i;
    }
  }
  return 100;
}
