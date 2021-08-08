int fib2(int n);

int fib1(int n) {
    if (n == 0 || n == 1) {
        return n;
    } else {
        return fib1(n - 1) + fib2(n - 2);
    }
}

int fib2(int n) {
    if (n == 0 || n == 1) {
        return n;
    } else {
        return fib1(n - 1) + fib2(n - 2);
    }
}

int main() {
    int n = 30;
    return fib1(n);
}