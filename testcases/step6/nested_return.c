int main() {
    int a = 1;
    int b = 1;
    {
        a = a + 2;
        {
            int a = 3;
            {
                int a = 4;
                {
                    int a = 5;
                    {
                        a = a + 6;
                        {
                            int a = 7;
                            {
                                a = a + 8;
                                {
                                    int a = 9;
                                    {
                                        int a = 10;
                                        {
                                            int b = 1;
                                        }
                                        b = b + a;
                                    }
                                }
                            }
                        }
                        b = b + a;
                    }
                    int b = 4;
                }
                int b = 77;
                {
                    int c = b;
                    {
                        int b = 3;
                    }
                    return b + a + a;
                }
            }
        }
        int b = 9;
    }
    return a + b;
}