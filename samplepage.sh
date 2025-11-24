#!/bin/bash
# A simple script to create a sample HTML page
#realtine dockersript

event=$(date +"%Y-%m-%d %T")
echo "Generating sample HTML page at $event"

# Function to print even numbers up to 1000
print_even_numbers() {
    echo "Printing even numbers less than 1000:"
    for ((i = 2; i < 1000; i += 2)); do
        echo $i
    done
}

# Call the function
print_even_numbers