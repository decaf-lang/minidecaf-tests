#!/bin/bash
export CC="riscv64-unknown-elf-gcc -std=c17 -march=rv32im -mabi=ilp32"
export QEMU=qemu-riscv32
export SPIKE="spike --isa=RV32G /usr/local/bin/pk"
if [ $(uname) = "Linux" ]; then
    export EMU=$QEMU
else
    export EMU=$SPIKE
fi

: ${USE_PARALLEL:=true}
: ${PROJ_PATH:=..}
export PROJ_PATH

: ${USE_PARALLEL:=true}
: ${PROJ_PATH:=..}

if [[ $CI_COMMIT_REF_NAME == "stage-1" ]]; then
    : ${STEP_FROM:=1}
    : ${STEP_UNTIL:=4}
elif [[ $CI_COMMIT_REF_NAME == "stage-2" ]]; then
    : ${STEP_FROM:=5}
    : ${STEP_UNTIL:=6}
elif [[ $CI_COMMIT_REF_NAME == "stage-3" ]]; then
    : ${STEP_FROM:=7}
    : ${STEP_UNTIL:=8}
elif [[ $CI_COMMIT_REF_NAME == "stage-4" ]]; then
    : ${STEP_FROM:=9}
    : ${STEP_UNTIL:=10}
elif [[ $CI_COMMIT_REF_NAME == "stage-5" ]]; then
    : ${STEP_FROM:=11}
    : ${STEP_UNTIL:=11}
elif [[ $CI_COMMIT_REF_NAME == "parser-stage" ]]; then
    : ${STEP_FROM:=1}
    : ${STEP_UNTIL:=6}
else
    echo "Warning: unknown branch"
    echo "All testcases are taken into account."
    : ${STEP_FROM:=1}
    : ${STEP_UNTIL:=11}
fi

if [[ $STEP_UNTIL -lt $STEP_FROM ]]; then
    echo "STEP_UNTIL < STEP_FROM: no tests run"
    exit 0
else
    JOBS=()
    for step in `seq ${STEP_FROM} ${STEP_UNTIL}`; do
        if [ -d "testcases/step${step}" ]; then
            JOBS+=($(eval echo testcases/step${step}/*.c))
        fi
    done

    FAILJOBS=()
    for step in `seq ${STEP_FROM} ${STEP_UNTIL}`; do
        if [ -d "failcases/step${step}" ]; then
            FAILJOBS+=($(eval echo failcases/step${step}/*.c))
        fi
    done
fi

gen_asm() {
    cfile=$(realpath "$1")
    asmfile=$(realpath "$2")

    # 根据特征文件判断所使用的语言
    if [[ -f $PROJ_PATH/requirements.txt ]]; then       # Python: minidecaf/requirements.txt
        python3.9 $PROJ_PATH/main.py --input $cfile --riscv >$asmfile
    elif [[ -f $PROJ_PATH/src/mind ]]; then             # C++: use the executable
        $PROJ_PATH/src/mind -l 5 -m riscv $cfile >$asmfile
    else
        touch _unrecog_impl
    fi
}
export -f gen_asm

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

run_job() {
    infile=$1
    outbase=${infile%.c}

    rm $outbase.{gcc,expected,err,my,actual,s} 1>/dev/null 2>&1

    $CC $infile -o $outbase.gcc
    $EMU $outbase.gcc >/dev/null
    echo $? > $outbase.expected

    if ! (
        gen_asm $infile $outbase.s &&
        $CC $outbase.s -o $outbase.my ) >$outbase.err 2>&1
    then
        echo -e "\n${YELLOW}ERR${NC} ${infile}"
        echo "==== Error information ======================================================="
        cat $outbase.err
        echo -e "==============================================================================\n"
        return 2
    fi
    $EMU $outbase.my >/dev/null
    echo $? > $outbase.actual

    if ! diff -q $outbase.expected $outbase.actual >/dev/null ; then
        echo -e "\n${RED}FAIL ${infile}"
        echo "==== Fail information (above: expected, below: actual) ======================="
        diff $outbase.expected $outbase.actual
        echo -e "==============================================================================\n"
        return 1
    else
        echo -e "${GREEN}OK${NC} ${infile}"
        return 0
    fi
}
export -f run_job


run_failjob() {
    infile=$1
    outbase=${infile%.c}

    rm $outbase.{my,s} 1>/dev/null 2>&1

    if (
        gen_asm $infile $outbase.s &&
        $CC $outbase.s -o $outbase.my ) >/dev/null 2>&1
    then
        echo -e "\n${RED}FAIL${NC} ${infile}"
        echo "==== Fail information (failed to detect input error) ========================="
        cat $outbase.s
        echo -e "==============================================================================\n"
        return 1
    else
        echo -e "${GREEN}OK${NC} ${infile}"
        return 0
    fi
}
export -f run_failjob


check_env_and_parallel() {
    if ! $CC --version >/dev/null 2>&1; then
        echo "gcc not found"
        exit 1
    fi
    echo "gcc found"

    if ! $EMU -h >/dev/null 2>&1; then
        echo "${EMU%% *} not found"
        exit 1
    fi
    echo "${EMU%% *} found"

    if $USE_PARALLEL && parallel --version >/dev/null 2>&1; then
        echo "running tests in parallel"
        return 0
    else
        echo "running tests serially"
        return 1
    fi
}


main() {
    echo "${#JOBS[@]} cases in total"
    if check_env_and_parallel; then
        parallel run_job ::: ${JOBS[@]}
        parallel run_failjob ::: ${FAILJOBS[@]}
    else
        for job in ${JOBS[@]}; do run_job $job; done
        for job in ${FAILJOBS[@]}; do run_failjob $job; done
    fi
}


cd "$(dirname "$0")"

if ! [[ -d $PROJ_PATH ]]; then
    echo "Put your code in $PROJ_PATH"
    exit 1
fi

if ! (main); then
    if [[ -f _unrecog_impl ]]; then
        echo "Unrecognized implementation. Are you using one of the supported language & frameworks? Or did you put check.sh in the wrong place?"
        rm _unrecog_impl;
    fi

    echo FAILED
    exit 1;
fi
