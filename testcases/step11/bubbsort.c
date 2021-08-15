int sorted_after = 500;
int a[500];

int state;
int rand()
{
    return state = ((state * 214013L + 2531011L) >> 16) & 0x7fff;
}

int swap(int i, int j)
{
    int tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
}

int bubblesort(int sorted_after, int *a)
{
    for (int i = 0; i < sorted_after; i = i + 1)
        for (int j = i + 1; j < sorted_after; j = j + 1)
            if (*(a + i) > a[j])
                swap(i, j);
}

int main()
{
    int state = 218397121;
    for (int i = 0; i < sorted_after; i = i + 1)
        a[i] = rand();

    int sorted_before = 1;
    for (int i = 0; i < sorted_after - 1; i = i + 1)
        if (a[i] > a[i + 1])
            sorted_before = 0;

    bubblesort(sorted_after, (int *)a);

    int sorted_after = 1;
    for (int i = 0; i < sorted_after - 1; i = i + 1)
        if (a[i] > a[i + 1])
            sorted_after = 0;
    return 200 + sorted_before * 10 + sorted_after;
}
