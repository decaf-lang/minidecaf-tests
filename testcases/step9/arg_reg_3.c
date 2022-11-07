// declared in runtime.h
int hash(int x, int y);
int read_arg_reg_8(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                   int a7);

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
    ret = ret + read_arg_reg_8(a0, a1, a2, a3, a4, a5, a6, a7);
  }
  return ret;
}
