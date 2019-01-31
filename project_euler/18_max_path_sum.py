#!/usr/bin/python

import sys

index_i = 0
twod_arr = []

while index_i < 4:
	index_j = 0
	arr = []
	while index_j < index_i:
		index_j += 1
		input = sys.stdin.readline()
		arr.append(int(input))
	twod_arr.append(arr)
	index_i += 1
		
print twod_arr[2][2]
				
