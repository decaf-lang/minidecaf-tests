int a;

int fun() {
    return a = 5;
}

int main() {
    int b = a;
    fun();
    return a + b;
}