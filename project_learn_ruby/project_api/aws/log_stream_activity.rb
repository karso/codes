require 'aws-sdk'
require 'date'
require 'logger'

LogFile = '/tmp/monitorlogstream.log'
Max_LogFile_Size = 1024000 # 1MB
Keep_LogFile = 10
LogLevel = Logger::INFO # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
LogFormat = '%Y-%m-%d %H:%M:%S'
DefaultRegion =  'us-east-1'
InactiveThreshold = 1800 # 30 mins

begin
  logger = Logger.new(LogFile, Keep_LogFile, Max_LogFile_Size)
rescue StandardError=>e
  puts "Error creating LogFile: #{e}"
end

logger.level = LogLevel
logger.datetime_format = LogFormat

@TIMEDIFF = InactiveThreshold

begin
  client = Aws::CloudWatchLogs::Client.new(region: DefaultRegion)
  resp1 = client.describe_log_groups()
  resp1.log_groups.each do |lg|
    resp2 = client.describe_log_streams({
      log_group_name: lg.log_group_name
    })
    resp2.log_streams.each do |ls|
      if (Time.now - @TIMEDIFF).utc > Time.at(ls.last_ingestion_time / 1000).utc
        logger.info { "The " + lg.log_group_name + "::" + ls.log_stream_name + " LogStream has sent no data for a while." }
      else
        logger.info { "The " + lg.log_group_name + "::" + ls.log_stream_name + " LogStream is working fine." }
      end
    end
  end
rescue StandardError=>e
  puts "Error: Executing AWS API call / Calculating TimeStamp"
  logger.error e
end

### TODO: Split a config file ###
