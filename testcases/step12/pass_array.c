int f(int a[]){
  a[0] = 10;
  return a[1] + a[2] * 2 + a[3] * 3; 
}

int main(){
  int b[4];
  b[1] = 2;
  b[2] = 3;
  b[3] = 4;
  int ans = f(b);
  ans = ans + b[0] * 2;
  return ans;
}