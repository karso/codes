#!/usr/bin/python

import boto3
import sys
   

def usage():
    print "python", sys.argv[0], "[region]", "[cluster]", "[container_count | pending_task | running_task | active_service]"
    exit (1)

try: 
    REGION = sys.argv[1]
    CLUSTER = sys.argv[2]
    QUERY = sys.argv[3]
except:
    usage() 

try:
    ecs_client = boto3.client('ecs', region_name=REGION)
    cluster_details = ecs_client.describe_clusters(clusters=[CLUSTER])
    # print cluster_details
except:
    print "AWS Region name looks fishy. Please retry as below."
    print "Valid region names are: \n [us-east-1] \n [us-west-2] \n [eu-east-1] \n [ca-central]"
    usage()     

if cluster_details['clusters'] != []:
    # print ecs_client.describe_clusters(clusters=[CLUSTER])
    ### Overall cluster status ###
    if cluster_details['clusters'][0]['status'] == 'ACTIVE':
        if QUERY == 'container_count':
            print cluster_details['clusters'][0]['registeredContainerInstancesCount']
        elif QUERY == 'pending_task':
            print cluster_details['clusters'][0]['pendingTasksCount']
        elif QUERY == 'running_task':
            print cluster_details['clusters'][0]['runningTasksCount']
        elif QUERY == 'active_service':
            print cluster_details['clusters'][0]['activeServicesCount']    
        else:
            print "I don't understand the query. Please try as below."
            usage()            
    else:
        print "The cluster " + CLUSTER + " was found inactive. Nothing for me to do. Exiting..."
        exit (1)                   
else:
    print "The cluster " + CLUSTER + " was not found. Make sure you are using correct cluster name"
    print "Nothing to do here for me. Exiting..."
    exit (1)    