int C[2][10000];
int P = 10000007;

int main() {
    int n = 5996;

    C[0][0] = 1;
    int b = 0;
    for (int i = 1; i <= n; i = i + 1) {
        for (int j = 0; j <= i; j = j + 1)
            C[1 - b][j] = !j ? 1 : (C[b][j] + C[b][j - 1]) % P;
        b = 1 - b;
    }

    if (C[b][0] != 1 || C[b][n] != 1 || C[1 - b][1] != n - 1) return 1;
    if (C[b][1234] != 6188476) return 2;
    if (C[b][2333] != 9957662) return 3;
    if (C[b][3456] != 9832509) return 4;
    if (C[b][5678] != 2436480) return 5;
    if (C[b][n / 2] != 7609783) return 6;
    return 0;
}
