#!/bin/bash
export CC="riscv64-unknown-elf-gcc -Dint=long"
export QEMU=qemu-riscv64
JOBS=(examples/step{1,2,3,4,5,6,7,8,9,10,11,12}/*.c)


gen_asm() {
    cfile=$1
    asmfile=$2

    # 如果是 python 参考代码，下面反注释
    # PYTHONPATH=../minidecaf python -m minidecaf $cfile $asmfile

    # 如果是 rust 参考代码，下面反注释
    # ../minidecaf/target/debug/minidecaf $cfile > $asmfile

    # 你自己写的编译器，仿照上面自行添加命令
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
        if [[ `cat $outbase.err` = "error: gen_asm undefined" ]]; then
            return 3
        else
            return 2
        fi
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
        echo "parallel found"
        return 0
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
    parallel run_job ::: ${JOBS[@]}
else
    for job in ${JOBS[@]}; do
        run_job $job
    done
fi
