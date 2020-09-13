# minidecaf-tests
The test suits for minidecaf compiler.

Recommended: install [GNU parallel](https://www.gnu.org/software/parallel/) to speed up checking by 3x more.
Any version should be fine.

Usage: just `./check.sh`. For each test case,
- `OK` indicates success;
- `FAIL` indicates divergence between your output and standard answer;
- `ERR` indicates that your compiler crashed, or produced malformed assembly.

In the same directory as the input files are the diagnostics, e.g. for `xx.c`:
- `xx.err`: in case of `ERR`, the error message
- `xx.expected`: the standard answer (by gcc)
- `xx.actual`: your output which you can diff against `xx.expected`
- `xx.{gcc,my}`: executables

Reference:
- [Nora Sandler's compiler testsuits](https://github.com/nlsandler/write_a_c_compiler)
