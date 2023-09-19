int fun(int a){
  return a;
}

int main(){
  int b[10] = {};
  fun(b);
  return b[0];
}