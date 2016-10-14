#!/usr/bin/ruby -w
=begin
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4
As 1 = 1^4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
=end

def fifth_pow_sum(num)
  sum = 0
  while num > 9
    last_dig = num % 10
    sum += last_dig ** 5
    num = (num / 10).to_i
  end
  sum += num ** 5
  return sum
end

# puts fifth_pow_sum(8208)

tot = 0
(1000..9999999).each do |num| # This limit was chosen based on trial and error. Not a good idea.
  if num == fifth_pow_sum(num)
     tot += num
  end
end
puts tot