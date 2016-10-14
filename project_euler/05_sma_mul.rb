#!/usr/bin/ruby -w

# 2520 is the smallest number that can be divided by each of the numbers from 1
# to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the
# numbers from 1 to 20?

LIM = 10
divsor = 2
prod = 1

def natNumArr(num)
  int_arr = []
  (1..num).each do |i|
    int_arr[i-1] = i
  end
  return int_arr
end

nat_num_arr = natNumArr(LIM)
num_of_ones = 0

while num_of_ones < LIM
  num_of_ones = 0
  index = 0
  divd = 0
  while index < LIM
    if nat_num_arr[index] == 1
      num_of_ones += 1
    elsif nat_num_arr[index] % divsor == 0
      nat_num_arr[index] /= divsor
      divd += 1
    end
    index += 1
  end
  if divd == 0
    divsor += 1
  else
    prod *= divsor
  end
end
puts prod 