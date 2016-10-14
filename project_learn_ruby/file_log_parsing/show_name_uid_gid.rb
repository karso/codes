#!/usr/bin/ruby -w

=begin

Show UserName, UID and GID of the users who has 
any login apart from nologin.

=end


filename = 'dummy_passwd'
file = File.open(filename, 'r')

file.each_line do |line|
  str = line.split(':')
  puts "#{str[0]}/#{str[2]}/#{str[3]}" unless str[6] == "/usr/sbin/nologin"
end