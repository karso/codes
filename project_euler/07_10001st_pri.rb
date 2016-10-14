#!/usr/bin/ruby -w
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

# What is the 10 001st prime number?

require 'prime'

cntr = 0
num = 0
while cntr < 10001
  num += 1
  if Prime.prime?(num)
    cntr += 1
  end
end
puts num
