#!/usr/bin/ruby -w

=begin

Given a number 'N', and an unsorted array of numbers (might have duplicates and zero),
figure out how many ways you can make 'N',
using two numbers from the array.

=end

input = 100

=begin
if ARGV.length == 0
  puts "Enter a value to test: "
  input_type = Integer(gets.chomp) rescue false
  exit if input_type == 0 
  input = input.to_i
elsif ARGV.length == 1
  input = ARGV[0].to_i
else
  puts "Too many inputs."
  exit
end
=end

int_arr1 = [2, 1, 1, 1, 9, 8, 3, 2, 1, 2, 1, 4, 11, 5, 1, 9, 82]

int_arr1 = int_arr1.sort.uniq

lo_end = 0
hi_end = 0

while int_arr1[hi_end] <= input
  hi_end += 1
  break if hi_end == int_arr1.size - 1
end

while hi_end > lo_end
  if int_arr1[lo_end] + int_arr1[hi_end] > input
    hi_end -= 1
  elsif int_arr1[lo_end] + int_arr1[hi_end] < input
    lo_end += 1
  else
    puts "(#{int_arr1[lo_end]}, #{int_arr1[hi_end]})"
    hi_end -= 1
    lo_end += 1
  end
end
