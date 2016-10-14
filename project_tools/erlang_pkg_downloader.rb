#!/usr/bin/ruby -w

=begin
This tool downloads packages basaed on their version.
The list of all the packages must be presented in a file.
Package list can be found at:  
https://packages.erlang-solutions.com/rpm/centos/6/x86_64/
=end


file = File.open('pkg_list.txt', 'r')
file.each_line do |line|
  if line.match('18.1-1') || line.match('R16B03-0.1')
     pkg_name = line.split(']')[1].to_s.split('rpm')[0] 
     pkg_name += 'rpm'
     pkg_name = pkg_name.strip
     puts "Downloading #{pkg_name}..."
     `wget  https://packages.erlang-solutions.com/rpm/centos/6/x86_64/#{pkg_name}`
  end
end
