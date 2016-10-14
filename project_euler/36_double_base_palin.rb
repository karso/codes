#!/usr/bin/ruby -w

# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.

# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

# (Please note that the palindromic number, in either base, may not include leading zeros.)

def baseTenPalindrome(num)
  if num == num.to_s.reverse.to_i
    return true
  else
    return false
  end  
end

def baseTwoPalindrome(num)
  if num.to_s(2) == num.to_s(2).reverse
    return true
  else
    return false
  end
end

i = 1
sum = 0
while i < 1000000
  sum += i if baseTenPalindrome(i) && baseTwoPalindrome(i)
  i += 1
end
puts sum
