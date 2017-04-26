require 'aws-sdk'
require 'date'
require 'logger'
require 'yaml'

begin
  conf_def = YAML.load_file('config.yml').fetch('Def')
  conf_log = YAML.load_file('config.yml').fetch('Log')
rescue StandardError => e
  puts "Failed to load config file 'config.yml'"
  puts e
end

LogFile = conf_log['FilePath']
Keep_LogFile = conf_log['KeepHistory']
Max_LogFile_Size = conf_log['MaxSize']
LogLevel = 'Logger::' + conf_log['Level']
LogFormat = conf_log['Format']

begin
  logger = Logger.new(LogFile, Keep_LogFile, Max_LogFile_Size)
rescue StandardError => e
  puts "Error creating LogFile: #{e}"
end

logger.level = LogLevel
logger.datetime_format = LogFormat
@TIMEDIFF = conf_def['InactiveThreshold']

begin
  client = Aws::CloudWatchLogs::Client.new(region: conf_def['Region'])
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
