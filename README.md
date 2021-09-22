# minidecaf-tests
MiniDecaf 测例及测试脚本。

我们有两种测例
- 普通测例（在 `testcases/` 下）：你的 MiniDecaf 要能成功编译这些测例到合法的汇编，然后正常返回（返回码为 0）。
  我们会将你的编译结果的运行返回值与 GCC 编译结果的运行返回值比较，要求它们必须要完全相同。
- 报错测例（在 `failcases/` 下）：你的 MiniDecaf 对于这些测例，要么不能正常返回（返回码非 0），要么不能生成合法汇编（例如输出中夹杂了报错信息）。
  最好能够生成有用的报错信息，但不要求。

## 依赖
- [RISCV工具链](https://decaf-lang.github.io/minidecaf-tutorial-deploy/docs/lab0/riscv.html)
- （可选）[GNU parallel](https://www.gnu.org/software/parallel/)，用于并行测试，对于多核机器可大幅提高测试速度（3-5 倍）。

## 用法
直接运行 `check.sh` 即可，例如在 `minidecaf-tests/` 目录下
```
$ ./check.sh
```

`check.sh` 支持如下参数，参数用法是 `OPT=VALUE ./check.sh`，多个 `OPT`-`VALUE` 对用空格隔开。
例如 `STEP_UNTIL=1 PROJ_PATH=../minidecaf ./check.sh`。

| 参数名 | 类型 | 含义 | 默认值 |
| --- | --- | --- | --- |
| `STEP_FROM` | 1 到 12 的整数（不超过`STEP_UNTIL`） | 从哪个 step 开始测 | 1 |
| `STEP_UNTIL` | 1 到 12 的整数 | 测到哪个 step | 12 |
| `PROJ_PATH` | 一个路径 | 你的 minidecaf 仓库的路径 | `..` |

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
遇到问题，请先尝试重设仓库，删除临时文件，撤销所有你的改动：
```
$ git clean -fdx
$ git checkout -- .
```

如果出错，除了下面内容也请阅读实验指导书的[常见问题](https://decaf-lang.github.io/minidecaf-tutorial/docs/step0/faq.html)一节。

* permission denied: ./check.sh
  - 需要给 `check.sh` 加执行权限 `chmod +x check.sh`
* gcc not found 或 qemu not found
  - 请按照[实验指导书](https://decaf-lang.github.io/minidecaf-tutorial/docs/lab0/env.html)配好环境。
* macOS 下找不到 realpath 命令
  ```
  ./check.sh: line 25: realpath: command not found
  ./check.sh: line 26: realpath: command not found
  ./check.sh: line 30: $asmfile: ambiguous redirect
  ```
  - 使用 Homebrew 安装 coreutils：`brew install coreutils`

## 参考
* [Nora Sandler's compiler testsuits](https://github.com/nlsandler/write_a_c_compiler)
