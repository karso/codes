# A script written in ruby that reads haproxy.log file and returns
# - The minimum response time since last n seconds.
# - The maximum response time last n seconds.
# - The average response time last n seconds.
# - The request rate in seconds since n seconds. (No. of incoming request in n seconds / n)
# - The bytes rate in seconds since n seconds. (No. of outgoing bytes in n seconds / n)

# ruby haproxy_log_parser.rb [haproxy log file location] [time in seconds] [method]
# e.g.: 
# ruby haproxy_log_parser.rb /var/log/haproxy.log 300 min_response_time 
#
# The above command will return the minimum response time since last 300 seconds as captured in /var/log/haproxy.log.
#
# Currently the following methods are supported:
# - min_response_time: Returns the minimum response time since last n secods.
# - max_response_time: Returns the maximum response time since last n secods.
# - avg_response_time: Returns the average response time since last n secods.
# - request_rate: Returns incoming request rate in seconds last n seconds.
# - bytes_rate:  Returns outgoing bytes rate in seconds last n seconds.


#!/usr/bin/ruby -w

require 'date'
require 'time'

LOG_LOCATION = ARGV[0]
TIME_PERIOD = ARGV[1]
FUNC = ARGV[2]

def usage()
	puts "#{$0} [logfile_location] [time_period] [function_name]"
	puts "logfile_location: The location and name of your haproxy log file eg. /var/log/haproxy.log"
	puts "time_period: The time period in seconds for which you want the values eg. 300 "
	puts "function_name: The function you want to call eg. min_response_time|max_response_time|avg_response_time"
end

def min_response_time(time_then, logfile)
	@time_then_min = time_then
	@logfile_min = logfile
	min_temp = 10000
	tr_min = -1
	file = File.open(@logfile_min, "r")
	str = file.read
	relv_log = str[str.index(/#{@time_then_min}.*/)..-1].split("\n")
	relv_log.each do |line|
		tr_s = line.match(%r"\d*/\d*/\d*/\d*/\d*").to_s.split(%r"/")[3]
		unless (tr_s.to_i.to_s != tr_s)
			if ( min_temp > tr_s.to_i)
				tr_min = tr_s.to_i
				min_temp = tr_s.to_i
			else
				tr_min = min_temp
			end
		end
	end
	puts tr_min
end
def max_response_time(time_then, logfile)
        @time_then_max = time_then
        @logfile_max = logfile
        max_temp = -1
        tr_max = 10000
        file = File.open(@logfile_max, "r")
        str = file.read
        relv_log = str[str.index(/#{@time_then_max}.*/)..-1].split("\n")
        relv_log.each do |line|
                tr_s = line.match(%r"\d*/\d*/\d*/\d*/\d*").to_s.split(%r"/")[3]
                unless (tr_s.to_i.to_s != tr_s)
                        if ( max_temp < tr_s.to_i)
                                tr_max = tr_s.to_i
                                max_temp = tr_s.to_i
                        else
                                tr_max = max_temp
                        end
                end
        end
        puts tr_max

end
def avg_response_time(time_then, logfile)
        @time_then_avg = time_then
        @logfile_avg = logfile
        count = 1
        tr_avg = 0
        file = File.open(@logfile_avg, "r")
        str = file.read
        relv_log = str[str.index(/#{@time_then_avg}.*/)..-1].split("\n")
        relv_log.each do |line|
                tr_s = line.match(%r"\d*/\d*/\d*/\d*/\d*").to_s.split(%r"/")[3]
                unless (tr_s.to_i.to_s != tr_s)
			tr_avg = tr_avg + tr_s.to_i
			count = count + 1
		end		
	end
	tr_avg = (tr_avg.to_f / count.to_f)
	puts tr_avg.round(2)

end

def request_rate (time_then, logfile, time_period)
        @time_then_rr = time_then
        @logfile_rr = logfile
        count = 1
        file = File.open(@logfile_rr, "r")
        str = file.read
        relv_log = str[str.index(/#{@time_then_rr}.*/)..-1].split("\n")
        relv_log.each do |line|
                tr_s = line.match(%r"\d*/\d*/\d*/\d*/\d*").to_s.split(%r"/")[3]
                unless (tr_s.to_i.to_s != tr_s)
                        count = count + 1
                end
        end
        req_rate = (count.to_f / time_period.to_f)
        puts req_rate.round(2)
	
end

def bytes_rate (time_then, logfile, time_period)
        @time_then_br = time_then
        @logfile_br = logfile
        byte_rate = 0
        file = File.open(@logfile_br, "r")
        str = file.read
        relv_log = str[str.index(/#{@time_then_br}.*/)..-1].split("\n")
        relv_log.each do |line|
                br_s = line.match(%r"\d*/\d*/\d*/\d*/\d*\s\d*\s\d*").to_s.split(%r"/")[4]
                unless line.start_with?(%r"\d*")
			br_s = br_s.to_s.split(%r"\s")[2]
                        byte_rate = byte_rate + br_s.to_i
                end
        end
        byte_rate = (byte_rate.to_f / time_period.to_f)
        puts byte_rate.round(2)
	
end

unless ARGV.length == 3
	puts "There are too few or too many arguments"
	usage
	exit
end

unless File.file?(LOG_LOCATION) 
	puts "The log file does not exist"
end

unless (TIME_PERIOD.to_i > 1) && (TIME_PERIOD.to_i.to_s == TIME_PERIOD)
	puts "Invalid time period"
	exit
end


time_now = DateTime.now
time_then = Time.at(Time.now.to_i - TIME_PERIOD.to_i).to_datetime.strftime("%b %d %H:%M:%S")

(1..TIME_PERIOD.to_i - 1 ).each do |sec|
	if open(LOG_LOCATION).grep(/#{time_then}/).length > 0
		break
	else
		time_str = Time.at(Time.now.to_i - TIME_PERIOD.to_i + sec.to_i).to_datetime
		time_then = time_str.strftime("%b %d %H:%M:%S")
		if sec.to_i == TIME_PERIOD.to_i - 1
			puts "-1"
			exit
		end
		next
	end
end

case FUNC		
	when "min_response_time"
		min_response_time(time_then,LOG_LOCATION)
	when "max_response_time"
		max_response_time(time_then,LOG_LOCATION)
	when "avg_response_time"
		avg_response_time(time_then,LOG_LOCATION)
	when "request_rate"
		request_rate(time_then,LOG_LOCATION,TIME_PERIOD.to_i)
	when "bytes_rate"
		bytes_rate(time_then,LOG_LOCATION,TIME_PERIOD.to_i)
	else
		puts "Invalid Fuunction call"
		exit
end
