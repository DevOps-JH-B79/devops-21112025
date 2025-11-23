#!/bin/bash



        #Write a shell script that names with my name.sh and he need to accept one argument ( a number) .the script should pring all the even numbers starting from 0 tup to the value
        print_evennumber() {

                        a=0
                        limit=$1
                        odd_numbers=''
                        even_numbers=''

                        while [ $a -lt $limit ]; do
                                if [ $(( a % 2 )) -eq 0 ]; then
                                        #echo " EvenNum: $a"
                                        even_numbers="${even_numbers} ${a}\n"
                                else
                                        #echo "OddNum: $a"
                                         odd_numbers="${odd_numbers} ${a}\n"
                                fi
                                a=$((a + 1))
                        done

                                echo "evenNumbers: "
                                echo -e "$even_numbers"

                                echo "OddNumbers: "
                                echo -e "$odd_numbers"
                }
                print_evennumber $1
                #./<filename.sh > <$1 value> "if wan store the values in saperate file then" > <filename>
