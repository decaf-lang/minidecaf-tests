    .text

    .global random
    # int random();
    # from C++ std::minstd_rand
    # only callee-saved registers are used
random:
    sw      s1, -4(sp)
    sw      s2, -8(sp)
    sw      s3, -12(sp)
    lui     s1, %hi(rng_state)
    lw      a0, %lo(rng_state)(s1)
    li      s2, 45056
    addi    s2, s2, -568
    remu    s3, a0, s2
    divu    a0, a0, s2
    li      s2, 49152
    addi    s2, s2, -881
    mul     s3, s3, s2
    li      s2, 4096
    addi    s2, s2, -697
    mul     a0, a0, s2
    bgeu    s3, a0, .L_RAND_0
    li      s2, -2147483648
    xori    s2, s2, -1
    add     s3, s3, s2
.L_RAND_0:
    sub     a0, s3, a0
    sw      a0, %lo(rng_state)(s1)
    lw      s1, -4(sp)
    lw      s2, -8(sp)
    lw      s3, -12(sp)
    ret

    .global hash
    # int hash(int,  int);
    # from boost.functional.hash
    # only callee-saved registers are used
hash:
    sw      s1, -4(sp)
    sw      s2, -8(sp)
    mv      s1, a1
    li      s2, -862048256
    addi    s2, s2, -687
    mul     s1, s1, s2
    slli    s2, s1, 15
    srli    s1, s1, 17
    or      s1, s1, s2
    li      s2, 461844480
    addi    s2, s2, 1427
    mul     s1, s1, s2
    xor     s1, s1, a0
    slli    s2, s1, 13
    srli    s1, s1, 19
    or      s2, s2, s1
    slli    a0, s2, 2
    add     a0, a0, s2
    li      s2, -430673920
    addi    s2, s2, -1180
    add     a0, a0, s2
    lw      s1, -4(sp)
    lw      s2, -8(sp)
    ret

    .global clear_caller_saved_registers
    # int clear_caller_saved_registers();
    # store an *interesting* magic number in caller saved registers
clear_caller_saved_registers:
    li      t0, 808
    li      t1, 017
    li      t2, 424
    li      t3, 794
    li      t4, 512
    li      t5, 875
    li      t6, 886
    li      a0, 459
    li      a1, 904
    li      a2, 961
    li      a3, 710
    li      a4, 757
    li      a5, 005
    li      a6, 754
    li      a7, 368
    ret

    .global read_arg_reg_1
    # int read_arg_reg_1(int);
    # return the hash of arguments
    # only callee-saved registers are used
read_arg_reg_1:
    ret

    .global read_arg_reg_2
    # int read_arg_reg_2(int, int);
    # return the hash of arguments
    # only callee-saved registers are used
read_arg_reg_2:
    addi    sp, sp, -4
    sw      ra, 0(sp)
    call    hash
    lw      ra, 0(sp)
    addi    sp, sp, 4
    ret

    .global read_arg_reg_4
    # int read_arg_reg_4(int, int, int, int);
    # return the hash of arguments
    # only callee-saved registers are used
read_arg_reg_4:
    addi    sp, sp, -24
    sw      ra, 0(sp)
    sw      s1, 4(sp)
    sw      s2, 8(sp)
    sw      s3, 12(sp)
    sw      s4, 16(sp)
    sw      s5, 20(sp)
    mv      s4, a0
    mv      s1, a1
    mv      s2, a2
    mv      s3, a3
    call    hash
    mv      s5, a0
    mv      a0, s2
    mv      a1, s3
    call    hash
    mv      a1, s5
    call    hash
    mv      a1, s1
    mv      a2, s2
    mv      a3, s3
    lw      ra, 0(sp)
    lw      s1, 4(sp)
    lw      s2, 8(sp)
    lw      s3, 12(sp)
    lw      s4, 16(sp)
    lw      s5, 20(sp)
    addi    sp, sp, 24
    ret

    # handle mangled function names in C++ framework
    .global _random
_random:
    j       random

    .global _hash
_hash:
    j       hash

    .global _clear_caller_saved_registers
_clear_caller_saved_registers:
    j       clear_caller_saved_registers

    .global _init
_init:
    j       init

    .global _read_arg_reg_1
_read_arg_reg_1:
    j       read_arg_reg_1

    .global _read_arg_reg_2
_read_arg_reg_2:
    j       read_arg_reg_2

    .global _read_arg_reg_4
_read_arg_reg_4:
    j       read_arg_reg_4

    .global _read_arg_reg_8
_read_arg_reg_8:
    j       read_arg_reg_8

    .global _read_arg_reg_16
_read_arg_reg_16:
    j       read_arg_reg_16

    .global _fill_n
_fill_n:
    j       fill_n
