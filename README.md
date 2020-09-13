# minidecaf-tests
MiniDecaf 测例。

推荐安装[GNU parallel](https://www.gnu.org/software/parallel/)以支持并行测试，
并行测试比串行测试快三至五倍。
parallel 版本没有什么要求，apt install 的就行。

## 用法
修改 `check.sh` 中的 `gen_asm` 函数，加入运行你编译器的命令。
然后直接 `./check.sh` 即可。

## 输出含义
* `OK` 测试点通过
* `ERR` 你的编译器崩了，或者输出的汇编格式不对
* `FAIL` （testcase）编译出的汇编运行结果不对；（failcase）或者对于不合法输入没报错而是输出了合法汇编。

## 用于 debug 的中间文件
测例文件在 `testcases/step*/*.c` 和 `failcases/step*/*.c`，运行 `./check.sh` 后同一目录下会有如下中间文件方便 debug
* `*.err`：`ERR` 的错误信息
* `*.expected`：用 gcc 编译运行得到的标准答案
* `*.actual`：运行你的编译结果得到的答案，需要和上面一样
* `*.{gcc,my}`：可执行文件

## 常见问题
* permission denied: ./check.sh
  - 需要给 `check.sh` 加执行权限 `chmod +x check.sh`
* gcc not found 或 qemu not found
  - 请按照[实验指导书](https://decaf-lang.github.io/minidecaf-tutorial/docs/lab0/env.html)配好环境。
    如果你没有安装到系统目录（即 `cp riscv-prebuilt/* /usr/ -r`），你还要设置环境变量。

## 参考
* [Nora Sandler's compiler testsuits](https://github.com/nlsandler/write_a_c_compiler)

