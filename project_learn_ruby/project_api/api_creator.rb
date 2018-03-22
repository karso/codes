#!/usr/bin/ruby -w

require "json"
require "net/http"
require "uri"

=begin
Pass a few parms and it will run REST API to get tenant status.
=end

env = "Trial"

puts "Enter Environment [1]"
puts "1. Trial"
puts "2. Loric"
input = gets.chomp.to_i
if (input == 2)
  env = "Loric"
end

if (env == "Trial")
  url = "http://trialstatus.use1.palerra.com"
else 
  url = "http://loricstatus.use1.palerra.com"
end

puts "Enter app name"
appname = gets.chomp

puts "Enter AppInstName"
appinstname = gets.chomp

puts "Enter Tenant ID"
tenantid = gets.chomp

exp_url = url + ":8080/admin/api/metrics/latest/details?appname=" +appname + "&appinstname=" + appinstname
app_tnnt_id = "X-Apprity-Tenant-Id:" + tenantid

command = "curl -i -H \"Accept: application/json\" -H \"Content-Type:application/json\" -H \"Accept-Language:en-us\" -H \"#{app_tnnt_id}\" -X GET \"#{exp_url}\"" 
res = %x(curl -i -H \"Accept: application/json\" -H \"Content-Type:application/json\" -H \"Accept-Language:en-us\" -H \"#{app_tnnt_id}\" -X GET \"#{exp_url}\").split("\n")
json_res =  JSON.parse(res[-1])
puts JSON.pretty_generate(json_res)
