#!/bin/bash
export CC=riscv64-unknown-elf-gcc
export QEMU=qemu-riscv64

JOBS=(examples/step*/*.c)


gen_asm() {
    cfile=$1
    asmfile=$2
    /tmp/minidecaf $cfile > $asmfile
}
export -f gen_asm


run_job() {
    infile=$1
    outbase=${infile%.c}

    $CC $infile -o $outbase.gcc
    $QEMU $outbase.gcc
    echo $? > $outbase.expected

    ( set -e
      gen_asm $infile $outbase.s
      $CC $outbase.s -o $outbase.my
    ) >$outbase.err 2>&1
    if [[ $? != 0 ]]; then
        echo "ERR ${infile}"
        return 1
    fi
    $QEMU $outbase.my
    echo $? > $outbase.actual

    if ! diff -qZ $outbase.expected $outbase.actual >/dev/null ; then
        echo "FAIL ${infile}"
        return 1
    else
        echo "OK ${infile}"
        if [[ $((RANDOM % 10)) = 10 ]]; then
            return 1;
        fi
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


if check_env_and_parallel; then
    parallel run_job ::: ${JOBS[@]}
else
    for job in ${JOBS[@]}; do
        run_job $job
    done
fi
