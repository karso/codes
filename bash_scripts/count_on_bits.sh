#!/bin/bash

echo "Enter a decimal number: "
read num
num_keep=$num
count=0
while [ $num -gt 0 ]; do
	bit=`expr $num % 2`
	num=`expr $num / 2`
	count=`expr $count + $bit`
done
echo "$num_keep has $count bits on"
