#!/usr/bin/ruby -w

=begin
The number 3797 has an interesting property.
Being prime itself, it is possible to continuously remove digits from left to right,
and remain prime at each stage: 3797, 797, 97, and 7.
Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
=end

require 'prime'

def trunc_pri(num)
  return false unless Prime.prime?(num)
  int_arr_lr = []
  int_arr_rl = []
  div = 10

  while div < num
    int_arr_rl.push(num % div)
    int_arr_lr.push((num / div).to_i)

    div *= 10
  end
  int_arr_rl.each do |elm|
    return false unless Prime.prime?(elm)
  end
  int_arr_lr.each do |elm|
    return false unless Prime.prime?(elm)
  end  
  return true
end

count = 0
sum = 0
num = 11
while count < 11
   if trunc_pri(num)
     sum += num
     puts num
     count += 1
   end
   num += 1
end

puts sum