int main() {
    int a[10];
    int *p=(int*) &a[4];
    return &a[9] - p;
}
