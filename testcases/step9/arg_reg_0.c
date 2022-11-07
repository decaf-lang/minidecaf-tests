// declared in runtime.h
int read_arg_reg_1(int a0);

int main() {
  // an *interesting* magic number
  return read_arg_reg_1(196883);
}
