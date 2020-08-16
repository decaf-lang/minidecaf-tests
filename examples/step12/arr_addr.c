int a[4];
int main() {
    if ((int) a != (int) &a)return 1;
    if ((int) a != (int) &a[0])return 1;
    return 0;
}
