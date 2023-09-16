int main() {
    int a = 233;
    {
        int a = (a = 1);
        return a;
    }
}