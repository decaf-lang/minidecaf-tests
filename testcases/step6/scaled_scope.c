int main() {
    int a = 1;
    int b = 0;
    {
        int a = 2;
        {
            int b = 98;
            int a = 4;
        }
        {
            int a = 6;
            int b = 0;
        }
        b = b + a;
    }
    {
        int a = 5;
        {
            int a = 7;
            b = b + a;
        }

    }
    return b + a;
}