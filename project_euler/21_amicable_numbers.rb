#!/usr/bin/ruby -w

=begin
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, 
then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; 
therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
=end

def prop_div(num)
  int_arr = [1]
  divsor = 2
  while divsor < num / 2
    break if int_arr.include?(num / divsor)
    if num % divsor == 0
      int_arr.push(divsor)
      int_arr.push(num / divsor)
    end
    divsor += 1
  end
  return int_arr.sort
end

def prop_div_sum(num)
  int_arr = prop_div(num)
  sum = 0
  int_arr.each do |i|
    sum += i
  end
  return sum
end

sum = 0
(1..10000).each do |num| 
  if num == prop_div_sum(prop_div_sum(num)) && num != prop_div_sum(num) 
    sum += num
  end
end

puts sum
