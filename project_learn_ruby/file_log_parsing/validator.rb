#!/usr/bin/ruby -w

ip_file = 'C:\Users\karsoumi\GIT\karso\codes\project_learn_ruby\file_log_parsing\validate.txt'
file = File.open(ip_file)
line_num = 1

def def_validator(num, str)
  dict_valid = { 1 => "Issue ID",
    2 => "Feature Name",
    3 => "Feature Description",
    4 => "To Do",
    5 => "Author"
  }

  if str.match(dict_valid[num])
    return true
  else
    return false
  end
end

file.each_line do |line|
  line_num += 1 if def_validator(line_num, line)
end

unless line_num > 5
  puts "Error"
else
  puts "Success"
end

file.close