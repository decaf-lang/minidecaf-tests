int fun(){
  int array[100] = {100};
  return array[10] + array[0];
}

int main(){
  int b[10] = {3, 4, 5};
  int ans = fun();
  for(int i = 0; i < 10; i = i + 1){
    ans = ans + b[i];
  }
  return ans;
}