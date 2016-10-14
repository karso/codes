#!/usr/bin/ruby -w

int_arr1 = [0, 5, 14, 22, 23]
int_arr2 = [1, 2, 4, 10, 14, 21, 25, 35]

int_arr3 = []

# int_arr3 = int_arr1 + int_arr2
# int_arr3 = int_arr3.sort
# puts int_arr3

arr1_ptr = 0
arr2_ptr = 0

while arr1_ptr < int_arr1.size && arr2_ptr < int_arr2.size
  if int_arr1[arr1_ptr] <= int_arr2[arr2_ptr]
    int_arr3.push(int_arr1[arr1_ptr])
    arr1_ptr += 1
  else
    int_arr3.push(int_arr2[arr2_ptr])
    arr2_ptr += 1
  end
end

if arr1_ptr == int_arr2.size - 1
  while arr1_ptr < int_arr1.size
    int_arr3.push(int_arr1[arr1_ptr])
    arr1_ptr += 1
  end
else
  while arr2_ptr < int_arr2.size
    int_arr3.push(int_arr2[arr2_ptr])
    arr2_ptr += 1
  end
end
puts int_arr3

