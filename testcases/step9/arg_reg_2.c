// declared in runtime.h
int random();
int read_arg_reg_4(int a0, int a1, int a2, int a3);

int main() {
  int a0 = random();
  int a1 = random();
  int a2 = random();
  int a3 = random();
  return read_arg_reg_4(a0, a1, a2, a3);
}
