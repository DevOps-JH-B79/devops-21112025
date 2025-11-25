#!/bin/bash
evenNumbers() {
# Function to print even numbers from 1 to n
#   n=$1
#   for (( i=0; i<n; i++ )); do
#     if (( i % 2 == 0 )); then
#       echo $i
#     fi
#   done


num=0

while [ $num -lt $1 ]; do
    if [[ $(( $num % 2 )) -eq 0  ]]; then
      echo $num
    fi
    num=$(($num + 1))
  done

}


evenNumbers 10