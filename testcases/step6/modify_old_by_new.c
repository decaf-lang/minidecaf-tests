int main() {
    int a = 1;
    int b = 2;
    {
        int a;
        a = 7;
    }
    {
        int b = 222;
        a = b + 1;
    }
    return a + b;
}