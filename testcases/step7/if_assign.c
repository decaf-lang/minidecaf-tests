int main(){
  int a = 0;
  int c = 1;
  if(c == (a = 1))
    c = -10;
  return a + c;
}
