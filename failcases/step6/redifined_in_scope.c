int main() {
    int a = 1;
    {
        a = 2;
        int a = 1;
        int a = 2;
    }
    return a;
}