#!/usr/bin/ruby -w

# A number chain is created by continuously adding the square of the digits in a
# number to form a new number,
# until it has been seen before.

# For example,

# 44 → 32 → 13 → 10 → 1 → 1
# 85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

# Therefore any chain that arrives at 1 or 89 will become stuck in an endless
# loop.
# What is most amazing is that EVERY starting number will eventually arrive at 1
# or 89.

# How many starting numbers below ten million will arrive at 89?


max_lim = 80
count = 0

def sumOfDigsSqrd(num)
  num_arr = num.to_s.split(//).map{|char| char.to_i}
  max_index = num_arr.size - 1
  sum = 0
  (0..max_index).each do |i|
    sum += num_arr[i] ** 2
  end
  return sum
end

def finalSumOfDigSqrd(num)
  if num == 1
    return false
  elsif num == 89
    return true
  else
    num = sumOfDigsSqrd(num)
    finalSumOfDigSqrd(num)
  end
end

while max_lim > 1
  count += 1 if finalSumOfDigSqrd(max_lim)
  max_lim -= 1
end

puts count
