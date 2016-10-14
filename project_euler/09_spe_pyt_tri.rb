#!/usr/bin/ruby -w
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000 

num1 = 1


while num1 <= 997
  num2 = num1 + 1
  while  num2 <= 999
    num3 = num2 + 1
    while num1 + num2 + num3 <= 1000 
      if num3 * num3 == num1 * num1 + num2 * num2 && num1 + num2 + num3 == 1000
        puts "#{num1} #{num2} #{num3}"
        puts num1 * num2 * num3
        flag = 1
      end
    if flag == 1 
      break
    end
    num3 = num3 + 1
    end
  if flag == 1 
    break
  end
  num2 = num2 + 1
  end
if flag == 1
  break
end
num1 = num1 + 1
end 
