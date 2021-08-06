int main() {
    int sum = 0;
    for (int i = 0; i < 10; i = i + 1) {
        for (int i = 0; i < 10; i = i + 1)
            break;
        sum = sum + i;
    }
    return sum;
}