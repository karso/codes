#!/bin/ruby -w

=begin
merge n sorted arrays.
=end

# This is the main thread
arr1 = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]
arr2 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40]
arr3 = [1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
arr4 = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225]
res1 = []
res2 = []

# The following method is not doing anything unless it is called. 
# It might be(?) part of the main thread, but inactive.  
def merge_arr(int_arr1, int_arr2)
  m_arr = []
  m_arr = int_arr1 + int_arr2
  m_arr = m_arr.sort  
  return m_arr
end

# This is thread1 which activates the above method. 
thrd1 = Thread.new do 
  res1 = merge_arr(arr1, arr2)
  puts res1.to_s
  puts "======"
end
# This is thread2 and similar as thread one but works on a different data set.
thrd2 = Thread.new do
  res2 = merge_arr(arr3, arr4)
  puts res2.to_s
  puts "====="
end
# We are making sure main thread resumes execution only after thread1 and thread2 is done.
thrd1.join
thrd2.join
puts merge_arr(res1, res2).to_s
