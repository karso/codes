#!/usr/bin/ruby -w
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million.

require 'prime'

i = 1
sum = 0
while i < 2000000
  if Prime.prime?(i)
    sum += i
  end
  i += 1
end
puts sum
