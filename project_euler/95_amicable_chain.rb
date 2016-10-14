#!/usr/bin/ruby -w

=begin
The proper divisors of a number are all the divisors excluding the number itself.
For example, the proper divisors of 28 are 1, 2, 4, 7, and 14.
As the sum of these divisors is equal to 28, we call it a perfect number.

Interestingly the sum of the proper divisors of 220 is 284
and the sum of the proper divisors of 284 is 220, forming a chain of two numbers.
For this reason, 220 and 284 are called an amicable pair.

Perhaps less well known are longer chains. For example, starting with 12496, we form a chain of five numbers:

12496 → 14288 → 15472 → 14536 → 14264 (→ 12496 → ...)

Since this chain returns to its starting point, it is called an amicable chain.

Find the smallest member of the longest amicable chain with no element exceeding one million.
=end

$ami_int_arr = []
$NUM = 0
$REC_CNT = 0

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

def amicable_chain(num)
  $ami_int_arr.push(num)
  if $NUM == prop_div_sum(num)
    $ami_int_arr.push(prop_div_sum(num))
    return $ami_int_arr
  elsif num > 1000000 || num < 10
    return []
  elsif $REC_CNT > 100
    return []
  else
    $REC_CNT += 1
    amicable_chain(prop_div_sum(num))
  end
end

=begin
num = 221 
$NUM = num
ami_chain_arr = amicable_chain(num) 
puts ami_chain_arr 
=end


(11..1000000).each do |num|
  $NUM = num
  $REC_CNT = 0
  ami_chain_arr = amicable_chain(num)
  puts "#{ami_chain_arr} : #{ami_chain_arr.size}" if ami_chain_arr.size > 2
  $ami_int_arr = []
end
