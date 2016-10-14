#!/usr/bin/ruby -w

=begin
Determine if a natural number is prime (w/o using inbuilt method).
=end

num = ARGV[0].to_i
# It would be better to check sanity of the i/p.

def isPrime(num)
  boundry = num ** 0.5
  (2..boundry.ceil).each do |i|
    if num % i == 0
      return false
    end
  end
  return true
end

if num <= 0
  puts "This input is invalid"
elsif num == 1
  puts "1 is undetermined"
else
  puts num if isPrime(num)
end 