// declared in runtime.h
int hash(int x, int y);
int read_arg_reg_16(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                    int a7, int a8, int a9, int a10, int a11, int a12, int a13,
                    int a14, int a15);

int main() {
  int ret = 0;
  for (int i = 0; i < 100; i = i + 1) {
    int a0 = i % 2;
    int a1 = i % 3;
    int a2 = i % 5;
    int a3 = i % 7;
    int a4 = i % 11;
    int a5 = i % 13;
    int a6 = i % 17;
    int a7 = i % 19;
    int a8 = i % 23;
    int a9 = i % 29;
    int a10 = i % 31;
    int a11 = i % 37;
    int a12 = i % 41;
    int a13 = i % 43;
    int a14 = i % 47;
    int a15 = i % 53;
    ret = ret + read_arg_reg_16(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10,
                                a11, a12, a13, a14, a15);
  }
  return ret;
}
