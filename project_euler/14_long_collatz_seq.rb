#!/usr/bin/ruby -w


# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:

# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?

# NOTE: Once the chain starts the terms are allowed to go above one million.

$length = 0

def collatzChainLength(num)
  if num == 1 
    return $length + 1
  elsif num % 2 == 0
    $length += 1
    collatzChainLength(num / 2)
  else
    $length += 1
    collatzChainLength(3 * num + 1)
  end
end

i = 1
longest_chain_length = 0
while i < 1000000
  chain_length = collatzChainLength(i)
  $length = 0
  if longest_chain_length < chain_length
    longest_chain_length = chain_length
    longest_chain_i = i
  end
  i += 1
end
puts longest_chain_length
puts longest_chain_i
