int g=123;
int *gp;
int main() {
    int a=456;
    int b=789;
    int *np=0;
    np=0;
    if (np != gp) return 244;
    if (np == &a) return 244;
    if (np == &g) return 244;
    if (&a == &g) return 244;
    if (&a == &b) return 244;
    if (&b == &g) return 244;
    a=23;
    np=&a;
    return*np;
}
