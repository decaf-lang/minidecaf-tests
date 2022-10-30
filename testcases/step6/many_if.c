int main(){
  int a = 0;
  if(a < 1)
    a = 2;
  if(a == 2)
    if(a != 3)
      if(a != 4)
        if(a != 5)
          if(a != 6)
            if(a != 2)
              a = 4;
            else
              a = 1;
          else
            a = 3;
        else
          a = 5;
      else
       a = 6;
    else
     a = 7;
  else
    a = 8;
  return a;
}
