#!/usr/bin/ruby -w

=begin
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. 
For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
=end

require 'prime'

arr = []
(0..9).each do |i|
  arr.push(i)
end

iter = 2

while iter < 3
  new_arr = arr.combination(iter).to_a
  new_arr.each { |sub_arr| puts sub_arr.to_s }
  iter += 1
end

