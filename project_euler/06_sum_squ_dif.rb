#!/usr/bin/ruby -w
# The sum of the squares of the first ten natural numbers is,

# 12 + 22 + ... + 102 = 385
# The square of the sum of the first ten natural numbers is,

# (1 + 2 + ... + 10)2 = 552 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.

# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

i_sum = 0
i_sum_sq = 0
(1..100).each do |i|
  i_sum += i
  i_sum_sq += i * i
end
dif_sum = i_sum * i_sum - i_sum_sq
puts dif_sum
