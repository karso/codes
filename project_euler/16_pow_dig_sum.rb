#!/usr/bin/ruby -w

# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2^1000?

def calSum(numarr)
  i = 0
  sum = 0
  while i < numarr.size
    sum += numarr[i]
  i+= 1
  end
  return sum
end


num = 1 << 1000
int_arr = num.to_s.split(//).map{|char| char.to_i}
puts calSum(int_arr)

