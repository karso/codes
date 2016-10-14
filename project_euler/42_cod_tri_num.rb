#!/usr/bin/ruby -w

=begin
The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position
and adding these values we form a word value.
For example, the word value for SKY is 19 + 11 + 25 = 55 = t10.
If the word value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'),
a 16K text file containing nearly two-thousand common English words, how many are triangle words?
=end

def pos_val(ch)
  return ch.ord - 'A'.ord + 1
end

def is_tri_num(num)
  index = 1
  tn = 0
  while tn < num
    tn = ( index * ( index + 1 ) ) / 2 
    index += 1
  end
  if tn == num
    return true
  else
    return false
  end
end

count = 0
file = File.open('words.txt', 'r')
file.each_line do |line|
  words = line.split(',')
  words.each do |word|
    word = word.gsub('"','')
    ltrs = word.split('')
    sum = 0
    ltrs.each do |ltr|
      sum += pos_val(ltr)      
    end
    if is_tri_num(sum)
      puts word 
      count += 1
    end
  end
end
puts count
file.close
