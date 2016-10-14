#!/usr/bin/ruby -w

=begin
Given an array of numbers find the duplicates
=end

int_arr1 = [2, 1, 0, 1, 1, 9, 8, 3, 2, 0, 0, 1, 2, 0, 1, 4, 11, 5, 1, 9, 82]

dups = 1

int_arr1 = int_arr1.sort


(0..int_arr1.size - 1).each do |index|
  if int_arr1[index] == int_arr1[index+1]
    # puts "#{int_arr1[index]} has duplicates." ## Says which number has duplicates
    dups += 1
  elsif int_arr1[index] != int_arr1[index+1] && dups != 1
    puts "#{int_arr1[index]} has #{dups} duplicates." ## Says which number has duplicates and how many
    dups = 1
  end
end
