#!/usr/bin/bash

input=$1

if [[ $input =~ ^[0-9]+$ ]]; then
	echo "Error: Invalid input. Parameter can't be a number."
else
	echo "Parameter value: $input"
fi
