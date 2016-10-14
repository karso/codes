#!/usr/bin/ruby -w

=begin

Count the number of lines entered within the
same minute. Use 'bigfile.log'.
(LinkedIn)

=end

passwd_file = File.open('bigfile.log', 'r')

time_str_arr = []
match_str = ''

reg_exp = '\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}'

passwd_file.each_line do |line|

  line_str = line.match("#{reg_exp}").to_s.split(':')[0]
  line_str += ":"
  line_str += line.match("#{reg_exp}").to_s.split(':')[1]

  if match_str != line_str && !time_str_arr.include?(line_str)
    # puts "#{match_str} -- #{line_str}"
    time_str_arr.push(line_str)
    match_str = line_str
  end

end
passwd_file.close

time_str_arr.each do |tstamp|
  count = 0  
  passwd_file = File.open('bigfile.log', 'r')
  passwd_file.each_line do |line|
    if line.include?("#{tstamp}")
      count += 1
    end
  end
  puts "#{tstamp} occurs #{count} times."
  passwd_file.close
end

