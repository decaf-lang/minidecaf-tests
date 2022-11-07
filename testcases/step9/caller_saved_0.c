// declared in runtime.h
int random();
int clear_caller_saved_registers();

int main() {
  int a = clear_caller_saved_registers();
  int b = clear_caller_saved_registers();
  int c = clear_caller_saved_registers();
  int d = clear_caller_saved_registers();
  int e = clear_caller_saved_registers();
  int f = clear_caller_saved_registers();
  int g = clear_caller_saved_registers();
  return a + b - c + d - e + f - g;
}
