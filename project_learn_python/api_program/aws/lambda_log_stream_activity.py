import boto3
import os
import sys, time
from datetime import datetime

''' 
Three environment variables need to be defined. 
TIME_DIFF => Acceptable period of inactivity. Def 30 mins.
LG_NAME => LogGroup Name. Def 'test'.
REGION => The AWS region where the LogGroup is. Def 'us-east-1'
'''

try:
  timeDiff = int(os.environ['TIME_DIFF'])
except:
  timeDiff = 1800
try:
  lgName = os.environ['LG_NAME']
except:
  lgName = 'test'

def check_ls_activity(event, context):
  try:
    region = os.environ['REGION']
  except:
    region = 'us-east-1'
  failedLS = 'Failed LogStreams: '
  client = boto3.client('logs', region_name=region)
  try:
    response1 = client.describe_log_groups(logGroupNamePrefix=lgName)
  except StandardError as e:
    print (e)  

  try:  
    for lg in response1['logGroups']:
      response2 = client.describe_log_streams(logGroupName=lg['logGroupName'])
      for ls in response2['logStreams']:
        if (int(round(time.time())) - timeDiff) < (ls['lastIngestionTime'] / 1000):
          print("The " + lg['logGroupName'] + "::" + ls['logStreamName'] + " LogStream is working fine.")
        else:
          print ("The " + lg['logGroupName'] + "::" + ls['logStreamName'] + " LogStream has sent no data for a while.")
          failedLS += ls['logStreamName'] + ','
  except StandardError as e:
    print(e)
  if (failedLS != 'Failed LogStreams: '):      
    raise Exception(failedLS)
    
