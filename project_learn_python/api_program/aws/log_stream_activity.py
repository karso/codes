import boto3
import sys, time
import logging
from datetime import datetime

timeDiff = 1800 # 30 mins
logFilePath = '/tmp/monitorlogstream.log'
logLevel = logging.INFO

try:
  logging.basicConfig(filename=logFilePath,format='%(asctime)s %(message)s',level=logLevel)
except StandardError as e:
  logging.error('ERROR: Creating log file %s', logFilePath)
  logging.error(e)

client = boto3.client('logs')
try:
  response1 = client.describe_log_groups()
except StandardError as e:
  logging.error('ERROR: Executing AWS API call')
  logging.error(e)

try:  
  for lg in response1['logGroups']:
    response2 = client.describe_log_streamss(logGroupName=lg['logGroupName'])
    for ls in response2['logStreams']:
      if (int(round(time.time())) - timeDiff) < (ls['lastIngestionTime'] / 1000):
        logging.info("The " + lg['logGroupName'] + "::" + ls['logStreamName'] + " LogStream is working fine.")
      else:
        logging.info("The " + lg['logGroupName'] + "::" + ls['logStreamName'] + " LogStream has sent no data for a while.")
except StandardError as e:
  logging.error('ERROR: Executing AWS API call / Calculating TimeStamp')
  logging.error(e)

### ToDo: Split config file ###
