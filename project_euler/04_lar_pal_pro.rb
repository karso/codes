#!/usr/bin/ruby -w

#require 'prime'

#beg_num = 100 * 100
#end_num = 999 * 999
#
#while end_num >= beg_num
#  if end_num > 99999 && end_num == end_num.to_s.reverse.to_i && !Prime.prime?(end_num) 
#    puts end_num

#    break
#  end
#  end_num -= 1
#end


start_val = 100
end_val = 999 
num = 0
hi_num = 0
(start_val..end_val).each do |n1| 
  (100..start_val).each do |n2|
    num = n1 * n2
    if num == num.to_s.reverse.to_i && num > hi_num
      hi_num = num
    end
  end
  start_val += 1
end
puts hi_num
