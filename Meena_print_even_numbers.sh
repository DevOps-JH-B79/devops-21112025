#!/bin/bash
n=10
for i in $(seq 0 $n);do
    if [[ $((i % 2)) == 0 ]];then
        echo "$i"
        
    fi
done