#!/usr/bin/ruby -w

# n! means n × (n − 1) × ... × 3 × 2 × 1

# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

# Find the sum of the digits in the number 100!



def genFactorial(n) 
  if n == 0
    return 1
  else
   n * genFactorial(n-1)
  end
end

index = 0
sum = 0 

fact_num = genFactorial(100)
int_arr = fact_num.to_s.split(//).map{|char| char.to_i}

while index < int_arr.size
  sum += int_arr[index]
  index += 1
end
puts sum
