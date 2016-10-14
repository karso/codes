#!/bin/ruby -w

require 'rubygems'
require 'net/http'
require 'uri'
require 'json'


url = "http://zabbix.dev.net/zabbix/api_jsonrpc.php"
headers = {"Content-Type" => "application/json"}        
username = "rfdev"
password = "dev0ps"
hostname = "haproxy"
log_location = "/var/haproxy/haproxy.log"
interval = "300"
function_list = {"Minimum response time"=>"min_resp_time", "Maximum response time"=>"max_resp_time", "Average response time"=>"avg_resp_time", "Request rate per sec"=>"request_rate", "Bytes out per sec"=> "bytes_rate"}
frontend_list = ["frontend_A", "frontend_B"]

uri = URI.parse(url)

auth_data = {"jsonrpc"=> "2.0", "method"=> "user.login", "params"=> { "user"=> username, "password"=> password}, "id" => "0"}                   
http_auth = Net::HTTP.new(uri.host,uri.port)   
response_auth = http_auth.post(uri.path,auth_data.to_json,headers)
auth_token = JSON.parse(response_auth.body)["result"]


host_data = {"jsonrpc"=>"2.0", "method"=>"host.get", "params"=>{"output"=>"extend", "filter"=>{"host"=>hostname}},"auth"=>auth_token,"id"=> "0"}
http_host = Net::HTTP.new(uri.host,uri.port)   
response_host = http_host.post(uri.path,host_data.to_json,headers)
host_id = JSON.parse(response_host.body)["result"][0]["hostid"]

interface_data = {"jsonrpc"=>"2.0","method"=>"hostinterface.get","params"=>{"output"=>"extend", "hostids"=>host_id},"auth"=>auth_token,"id"=>"0"}
http_interface = Net::HTTP.new(uri.host,uri.port)
response_interface = http_interface.post(uri.path,interface_data.to_json,headers)
interface_id = JSON.parse(response_interface.body)["result"][0]["interfaceid"]

frontend_list.each do |fename| 
	function_list.each do |key, funcname|
		item_data = {"jsonrpc"=> "2.0", "method"=> "item.create", "params"=> {"name"=>"#{key} for #{fename}", "key_"=> "haproxy.stat[#{log_location}, #{interval}, #{funcname}, #{fename}]", "hostid"=> host_id, "type"=> "0", "value_type"=> "0", "interfaceid"=> interface_id, "delay"=> 300}, "auth"=> auth_token, "id"=> "0"}
		http_item = Net::HTTP.new(uri.host,uri.port)
		response_item = http_item.post(uri.path,item_data.to_json,headers)
		item_id = JSON.parse(response_item.body)
		error_message = item_id["error"].to_s
		if error_message.length > 0
			puts "Item \"#{key} for #{fename}\" could NOT be created"
		else
			puts "Item \"#{key} for #{fename}\" SUCCESSFULLY created"
		end
	end
end
