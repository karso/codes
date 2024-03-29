#!/usr/bin/ruby -w
=begin
The sequence of triangle numbers is generated by adding the natural numbers. 
So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

Let us list the factors of the first seven triangle numbers:

 1: 1
 3: 1,3
 6: 1,2,3,6
10: 1,2,5,10
15: 1,3,5,15
21: 1,3,7,21
28: 1,2,4,7,14,28
We can see that 28 is the first triangle number to have over five divisors.

What is the value of the first triangle number to have over five hundred divisors?
=end

def all_div(num)
  int_arr = [1]
  divsor = 2
  return int_arr if num == 1
  while divsor < num / 2
    break if int_arr.include?(num / divsor)
    if num % divsor == 0
      int_arr.push(divsor)
      int_arr.push(num / divsor)
    end
    divsor += 1
  end
  int_arr.push(num)
  return int_arr.sort
end

tri_num = 0
next_num = 0
while true
  tri_num += next_num  + 1
  next_num += 1
  int_arr = all_div(tri_num)
  puts "Triange Number: #{tri_num}"
  if int_arr.size >= 500
    puts "#{tri_num} : #{int_arr.size}"
    break
  end  
end

