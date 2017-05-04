#!/usr/bin/ruby -w

=begin
It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2×1^2
15 = 7 + 2×2^2
21 = 3 + 2×3^2
25 = 7 + 2×3^2
27 = 19 + 2×2^2
33 = 31 + 2×1^2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
=end


require 'prime'

oc_num = 1

def nextOcNum(num)
  found = false
  while !found
    if Prime.prime?(num)
      num += 2
    else
      found true
      return num
    end
  end
end


def GBNum(num) 
  divs = num - 1 
  while divs > 1
    if Prime.prime(divs)
      tmp_num = num - divs
      if tmp_num % 2 == 0 and Math.sqrt(tmp_num / 2) 
        tmp_num /= 2
      end
    else
      divs -= 1
  end
end

puts oc_num
