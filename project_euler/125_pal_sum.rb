#!/usr/bin/ruby -w

# The palindromic number 595 is interesting because it can be written as the sum
# of consecutive squares:
# 6^2 + 7^2 + 8^2 + 9^2 + 10^2 + 11^2 + 12^2.
# There are exactly eleven palindromes below one-thousand that can be written as
# consecutive square sums,
# and the sum of these palindromes is 4164.
# Note that 1 = 0^2 + 1^2 has not been included as this problem is concerned with
# the squares of positive integers.
# Find the sum of all the numbers less than 10^8 that are both
# palindromic and can be written as the sum of consecutive squares.



###@@@ It works for 1000 but not for 100000000. Gives a wrong result. @@@###
###@@@ BTW, it is inefficient since it runs at O(n^2) time.           @@@###

=begin
max_lim = 100000000
grnd_sum = 0 
tot = 0 

def isPalindrome(num)
  if num == num.to_s.reverse.to_i
    puts num
    return true
  else
    return false
  end
end

(1..max_lim).each do |i|
  j = i
  sum = j ** 2
  j += 1
  while sum <= max_lim
    sum += j ** 2
    j += 1
    if isPalindrome(sum) && sum < max_lim
      tot += 1
      grnd_sum += sum
    end
  end 
end
puts "----"
puts grnd_sum
puts tot
=end

# Generate palindromes in the range of 1..100000000
# Check if the palindrome can be expressed as the sum of consecutive squares.

