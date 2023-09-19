int n = 1000000;
int arr[1000000];

int qsort(int a[1000000], int l, int r) {
    int i = l;
    int j = r;
    int p = a[(l+r)/2];
    int flag = 1;
    while (i <= j) {
        while (a[i] < p) i = i + 1;
        while (a[j] > p) j = j - 1;
        if (i > j) break;
        int u = a[i]; a[i] = a[j]; a[j] = u;
        i = i + 1;
        j = j - 1;
    }
    if (i < r) qsort(a, i, r);
    if (j > l) qsort(a, l, j);
    return 0;
}

int state;
int rand() {
    state = (state * 64013 + 1531011) % 32768;
    return state % 1000;
}

int initArr(int n) {
    int i = 0;
    while (i < n) {
        arr[i] = rand();
        i = i + 1;
    }
    return 0;
}

int isSorted(int n) {
    int i = 0;
    while (i < n-1) {
        if ( arr[i] > arr[i+1] )
            return 0;
        i = i + 1;
    }
    return 1;
}

int main() {
    initArr(n);
    int sorted_before = isSorted(n);
    qsort(arr, 0, n-1);
    int sorted_after = isSorted(n);
    if (!(sorted_before==0 && sorted_after==1))
        return 1;
    return 0;
}
