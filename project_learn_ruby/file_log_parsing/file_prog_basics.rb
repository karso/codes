#!/usr/bin/ruby -w

### Needed for pattern matching part

# require 'date'

file_name = 'rana.txt'

### Create a file called rana.txt
File.open(file_name, 'w')

### Put a line about Rana in that file with a new line.
# File.open('file_name', 'w') { |file| file.write("Call it peace,\n")}
file1 = File.open(file_name, 'w')
file1.puts('Call it peace,')
file1.close ## Optional for a script. Needed for a good program

### Add more lines to the file.
file3 = File.open(file_name, 'a')
file3 << 'Call it treason.' # Creates a new line.
file3.puts('Call it love,') # Appends to the same line.
file3.write('Call it reason.')
file3.close

### Read the file and output it on console.
file4 = File.open(file_name, 'r')
text = file4.read
puts text
file4.close

### Read the file line by line.
file4 = File.open(file_name)
file4.each_line do |l|
  puts l
  puts '----'
end

### Read the file in reverse order
puts "Read Reverse..."
index = -1
while index >= -3
  file4 = File.open(file_name)
  line_str = file4.readlines[index]
  puts line_str
  ### Match a substring
  puts "We found \"treason\"" if line_str.include?('treason')
  index -= 1
end

### Read a file w/o loading it in memory and match a pattern
### First create a big file filled with random strings.
=begin
fileBig = File.open('bigfile.log', 'a')
(1..10000).each do
  fileBig << Time.now
  fileBig << " "
  fileBig << (0...50).map { ('a'..'z').to_a[rand(26)] }.join
  fileBig << "\n"
  sleep(1/100)
end
fileBig.close
=end
### Pattern match
fileBig = File.read('bigfile.log')
regExp1 = '\d{4}-\d{2}-\d{2}'
regExp2 = '\d{2}:\d{2}:\d{2}'
regExp3 = '\d*/\d*/\d*'
fileBig.each_line do |line|
  puts line.gsub(/-/, "") if line.match(/#{regExp1}/).to_s.split(/-/)[0].to_i > 2016
  # puts Date::MONTHNAMES[line.match(/#{regExp1}/).to_s.split(/-/)[1].to_i]
  puts line.gsub(/:/, "/") if line.match(/#{regExp2}/).to_s.split(/:/)[2].to_i > 52
  new_line = line.gsub(/:/, "/")
  puts new_line if new_line.match(/#{regExp3}/).to_s.split(/\//)[2].to_i > 52
end

exit
### Copy a file to another new file
new_file = 'RANA.txt'
file4 = File.open(file_name)
file5 = File.open(new_file, 'a')
file4.each_line do |l|
  file5.puts(l)
end
file4.close
file5.close
file5 = File.open(new_file, 'r')
text = file5.read
puts '----'
puts text
file5.close

### Remove the file
File.delete(file_name)
File.delete(new_file)
