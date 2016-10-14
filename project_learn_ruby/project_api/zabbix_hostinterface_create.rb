#!/opt/chef/embedded/bin/ruby -w

require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

url = "http://10.0.40.16/zabbix/api_jsonrpc.php"
headers = {"Content-Type" => "application/json"}        
username = "Admin"
password = "zabbix"
hostname = "Zabbix server"
add_jmx_interface_port = [12322, 12323]
current_jmx_interface_port = []

uri = URI.parse(url)

auth_data = {"jsonrpc"=> "2.0", "method"=> "user.login", "params"=> { "user"=> username, "password"=> password}, "id" => "0"}                   
http_auth = Net::HTTP.new(uri.host,uri.port)   
response_auth = http_auth.post(uri.path,auth_data.to_json,headers)
auth_token = JSON.parse(response_auth.body)["result"]
if auth_token.nil?
        puts "The username' or the password is not valid"
        exit
end

host_data = {"jsonrpc"=>"2.0", "method"=>"host.get", "params"=>{"output"=>"extend", "filter"=>{"host"=>hostname}},"auth"=>auth_token,"id"=> "0"}
http_host = Net::HTTP.new(uri.host,uri.port)   
response_host = http_host.post(uri.path,host_data.to_json,headers)
host_id = JSON.parse(response_host.body)["result"][0]["hostid"]

jmx_interface_get = {"jsonrpc"=>"2.0","method"=>"hostinterface.get","params"=>{"output"=>"extend", "hostids"=>host_id, "filter"=>{"type"=>4}},"auth"=>auth_token,"id"=>"0"}
http_interface = Net::HTTP.new(uri.host,uri.port)
response_jmx_interface_get = http_interface.post(uri.path,jmx_interface_get.to_json,headers)
jmx_interface_list = JSON.parse(response_jmx_interface_get.body)["result"]
jmx_interface_list.each do |interface|
	current_jmx_interface_port.push(interface["port"].to_i)
end

final_jmx_interface_list = add_jmx_interface_port.sort - (add_jmx_interface_port.sort & current_jmx_interface_port.sort)

final_jmx_interface_list.each do |port|
	jmx_interface_data = {"jsonrpc"=>"2.0","method"=>"hostinterface.create","params"=>{"hostid"=>host_id, "dns"=>"", "ip"=>"127.0.0.1", "main"=>0,"port"=>port, "type"=>4, "useip"=>1},"auth"=>auth_token,"id"=>"0"}
	http_interface = Net::HTTP.new(uri.host,uri.port)
	jmx_response_interface = http_interface.post(uri.path,jmx_interface_data.to_json,headers)
	jmx_interface_created = JSON.parse(jmx_response_interface.body)["id"]
	unless jmx_interface_created
		puts "Failed to create JMX interface."
	end
end
