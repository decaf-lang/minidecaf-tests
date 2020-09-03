#!/bin/bash
export CC="riscv64-unknown-elf-gcc  -march=rv32im -mabi=ilp32"
export QEMU=qemu-riscv32
USE_PARALLEL=${true:-$USE_PARALLEL}
JOBS=(testcases/step{1,2,3,4,5,6,7,8,9,10,11,12}/*.c)


gen_asm() {
    cfile=$1
    asmfile=$2

    # 如果是 Python-ANTLR 参考代码，下面反注释
    # PYTHONPATH=../minidecaf python -m minidecaf $cfile $asmfile

    # 如果是 Rust-lalr1 参考代码，下面反注释
    # ../minidecaf/target/debug/minidecaf $cfile > $asmfile

    # 你自己写的编译器，仿照上面自行添加命令

    echo "======== No compiler set! Check gen_asm! ========"
}
export -f gen_asm


run_job() {
    infile=$1
    outbase=${infile%.c}

    rm $outbase.{gcc,expected,err,my,actual,s} 1>/dev/null 2>&1

    $CC $infile -o $outbase.gcc
    $QEMU $outbase.gcc
    echo $? > $outbase.expected

    ( set -e
      gen_asm $infile $outbase.s
      $CC $outbase.s -o $outbase.my
    ) >$outbase.err 2>&1
    if [[ $? != 0 ]]; then
        echo "ERR ${infile}"
        return 2
    fi
    $QEMU $outbase.my
    echo $? > $outbase.actual

    if ! diff -qZ $outbase.expected $outbase.actual >/dev/null ; then
        echo "FAIL ${infile}"
        return 1
    else
        echo "OK ${infile}"
        return 0
    fi
}
export -f run_job


check_env_and_parallel() {
    if $CC --version >/dev/null 2>&1; then
        echo "gcc found"
    else
        echo "gcc not found"
        exit 1
    fi

    if $QEMU -version >/dev/null 2>&1; then
        echo "qemu found"
    else
        echo "qemu not found"
        exit 1
    fi

    if parallel --version >/dev/null 2>&1; then
        if $USE_PARALLEL; then
            echo "parallel found"
            return 0
        else
            echo "parallel found but not used"
            return 1
        fi
    else
        echo "parallel not found"
        return 1
    fi
}


if ! [[ -d ../minidecaf ]]; then
    echo "Put your code in ../minidecaf"
    exit 1
fi

if check_env_and_parallel; then
    parallel --halt now,fail=1 run_job ::: ${JOBS[@]}
else
    for job in ${JOBS[@]}; do
        if ! run_job $job; then break; fi
    done
fi
