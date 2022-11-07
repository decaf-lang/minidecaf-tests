// declared in runtime.h
int random();
int hash(int x, int y);
int init();
int read_arg_reg_16(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                    int a7, int a8, int a9, int a10, int a11, int a12, int a13,
                    int a14, int a15);

int main() {
  init();
  for (int i = 0; i < 100; i = i + 1) {
    int a0 = random();
    int a1 = random();
    int a2 = random();
    int a3 = random();
    int a4 = random();
    int a5 = random();
    int a6 = random();
    int a7 = random();
    int a8 = random();
    int a9 = random();
    int a10 = random();
    int a11 = random();
    int a12 = random();
    int a13 = random();
    int a14 = random();
    int a15 = random();
    int h = hash(hash(hash(hash(a0, a1), hash(a2, a3)),
                      hash(hash(a4, a5), hash(a6, a7))),
                 hash(hash(hash(a8, a9), hash(a10, a11)),
                      hash(hash(a12, a13), hash(a14, a15))));
    int r = read_arg_reg_16(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11,
                            a12, a13, a14, a15);
    if (h != r) {
      return i;
    }
  }
  return 100;
}
