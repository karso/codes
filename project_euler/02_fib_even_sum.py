fib1 = 1
fib2 = 2
sum = 0

while (fib1 < 4000000): 
  print fib1
  fibtmp = fib1
  fib1 = fib2 
  fib2 = fibtmp + fib1
  if (fib1 % 2 == 0):
    sum += fib1
print sum
