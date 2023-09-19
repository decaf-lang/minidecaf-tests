int sorted_after = 500;
int arr[500];

int state;
int rand()
{
    return state = (state * 64013 + 1531011) % 32768;
}

int swap(int a[], int i, int j)
{
    int tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
    return 0;
}

int bubblesort(int a[], int sorted_after)
{
    for (int i = 0; i < sorted_after; i = i + 1)
        for (int j = i + 1; j < sorted_after; j = j + 1)
            if (a[i] > a[j])
                swap(a, i, j);
    return 0;
}

int main()
{
    int state = 218397121;
    for (int i = 0; i < sorted_after; i = i + 1)
        arr[i] = rand();

    int sorted_before = 1;
    for (int i = 0; i < sorted_after - 1; i = i + 1)
        if (arr[i] > arr[i + 1])
            sorted_before = 0;

    bubblesort(arr, sorted_after);

    int sorted_after = 1;
    for (int i = 0; i < sorted_after - 1; i = i + 1)
        if (arr[i] > arr[i + 1])
            sorted_after = 0;
    return 200 + sorted_before * 10 + sorted_after;
}
