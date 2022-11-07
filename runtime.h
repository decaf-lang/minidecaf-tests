// defined in runtime.s
int random();
int hash(int x, int y);
int clear_caller_saved_registers();
int read_arg_reg_1(int a0);
int read_arg_reg_2(int a0, int a1);
int read_arg_reg_4(int a0, int a1, int a2, int a3);

// defined in runtime.c
int init();
int read_arg_reg_8(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                   int a7);
int read_arg_reg_16(int a0, int a1, int a2, int a3, int a4, int a5, int a6,
                    int a7, int a8, int a9, int a10, int a11, int a12, int a13,
                    int a14, int a15);
int fill_n(int a[], int n, int v);
