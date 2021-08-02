int main() {
    int a;
    a = (a = 1 ? (a = 0): (a = 2));
    return a;
}