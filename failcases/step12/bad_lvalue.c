int a;
int main() {
    int *p = &a;
    int *q;
    q = &*p;
    &*p = q;
}
