int main() {
    int a = 1;
    int b = 3;
    {
        int b = 5;
    }
    return a + b;
}