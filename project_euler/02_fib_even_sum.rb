#!/usr/bin/ruby -w

fib1 = 1
fib2 = 2
sum = 0
while fib1 < 4000000
  puts fib1
  fibtmp = fib1
  fib1 = fib2
  fib2 = fibtmp + fib1
  if fib1.even?
    sum += fib1
  end
end
puts sum
