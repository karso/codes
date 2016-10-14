#!/usr/bin/ruby -w
# What is the index of the first term in the Fibonacci sequence to contain 1000 digits?


fib1 = 1
fib2 = 1
index = 1

def numOfDig(num)
  int_arr = num.to_s.split(//).map{|char| char.to_i}
  return int_arr.size
end

while numOfDig(fib1) < 1000
  tmp = fib1
  fib1 = fib2
  fib2 = fib1 + tmp
  index += 1
end
puts index
