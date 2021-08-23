int main() {
    int fi[30];
    fi[0] = 0;
    fi[1] = 1;
    for (int i = 2; i < 30; i = i + 1)
        fi[i] = fi[i - 2] + fi[i - 1];
        
    if (fi[2] != 1) return 2;
    if (fi[3] != 2) return 3;
    if (fi[4] != 3) return 4;
    if (fi[5] != 5) return 5;
    if (fi[6] != 8) return 6;
    if (fi[7] != 13) return 7;
    if (fi[8] != 21) return 8;
    if (fi[9] != 34) return 9;
    if (fi[10] != 55) return 10;
    if (fi[11] != 89) return 11;
    if (fi[12] != 144) return 12;
    if (fi[13] != 233) return 13;
    if (fi[14] != 377) return 14;
    if (fi[15] != 610) return 15;
    if (fi[16] != 987) return 16;
    if (fi[17] != 1597) return 17;
    if (fi[18] != 2584) return 18;
    if (fi[19] != 4181) return 19;
    if (fi[20] != 6765) return 20;
    if (fi[21] != 10946) return 21;
    if (fi[22] != 17711) return 22;
    if (fi[23] != 28657) return 23;
    if (fi[24] != 46368) return 24;
    if (fi[25] != 75025) return 25;
    if (fi[26] != 121393) return 26;
    if (fi[27] != 196418) return 27;
    if (fi[28] != 317811) return 28;
    if (fi[29] != 514229) return 29;

    return 0;
}