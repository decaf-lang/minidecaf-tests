for i in examples/*/*.c
do
    gcc -w -m32 $i             #compile with gcc
    ./a.out                 	#run it
    expected=$?             	#get exit code
    gcc -w -m32 -o out $i      #compile with YOUR COMPILER or some shell script with YOUR COMPILER
    base="${i%.*}"
    ./out                      #run the thing we assembled
    actual=$?                  #get exit code
    echo -n "$i:    "
    if [ "$expected" -ne "$actual" ]
    then
        echo "FAIL"
    else
        echo "OK"
    fi
    rm out a.out
done

#tested in ubutnu 20.04 x86-64
