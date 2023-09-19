int main(){
  int b[10] = {3, 4, 5};
  int ans = 0;
  for(int i = 0; i < 10; i = i + 1){
    ans = ans + b[i];
  }
  return ans;
}