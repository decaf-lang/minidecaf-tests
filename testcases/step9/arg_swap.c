int g(int a, int b) {
    return a + b;
}

int f(int x, int y) {
    return g(y, x);
}

int main() {
    return f(2, 3);
}