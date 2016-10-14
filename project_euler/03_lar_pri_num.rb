#!/usr/bin/ruby -w

require 'prime'

big_num = 600851475143
big_num_sqrt = Math.sqrt(big_num).floor

while big_num_sqrt > 1
  if Prime.prime?(big_num_sqrt) && big_num % big_num_sqrt == 0
    if Prime.prime?(big_num / big_num_sqrt) 
      puts big_num / big_num_sqrt
    else
      puts big_num_sqrt
    end
    break
  end
  big_num_sqrt -= 1
end
