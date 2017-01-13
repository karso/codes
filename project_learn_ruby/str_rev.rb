#!/bin/ruby -w

=begin
Write a program to reverse a char array without using string function and without using another char array  
Oracle
=end

str = 'Reverse a char array without using string function and without using another char array'

cha_arr = str.split('')
lft_ptr = 0
rgt_ptr = cha_arr.length - 1

while lft_ptr < rgt_ptr
  break if lft_ptr == rgt_ptr
  tmp_chr = cha_arr[lft_ptr]
  cha_arr[lft_ptr] = cha_arr[rgt_ptr]
  cha_arr[rgt_ptr] = tmp_chr
  lft_ptr += 1
  rgt_ptr -= 1
end
puts cha_arr.join('')
