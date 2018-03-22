#!/usr/bin/python

import boto3
import sys
   

def usage():
    print "python", sys.argv[0], "[region]", "[cluster]"
    exit (1)

try: 
    REGION = sys.argv[1]
    CLUSTER = sys.argv[2]
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
        print "Cluster ", cluster_details['clusters'][0]['clusterName'], "is Active" + " with", cluster_details['clusters'][0]['registeredContainerInstancesCount'], "container instances"
        print "Number of Pending Tasks: ", cluster_details['clusters'][0]['pendingTasksCount']
        print "Number of Running Tasks: ", cluster_details['clusters'][0]['runningTasksCount']
        print "Number of active Services: ", cluster_details['clusters'][0]['activeServicesCount']            
        print "---------------------------------------------------"
            
        ecs_service = ecs_client.list_services(cluster=cluster_details['clusters'][0]['clusterName'])
        print "The cluster", cluster_details['clusters'][0]['clusterName'], "has the following services"
        for service in ecs_service['serviceArns']:
            print "Service Name:", service.split('/')[1]
                
            ecs_task_def = ecs_client.describe_services(cluster=cluster_details['clusters'][0]['clusterName'], services=[service])
            print "\t Task Definition:", ecs_task_def['services'][0]['taskDefinition'].split('/')[1]
                
            ecs_task = ecs_client.list_tasks(cluster=cluster_details['clusters'][0]['clusterName'], serviceName=service.split('/')[1])
            print "\t Task ID:", ecs_task['taskArns'][0].split('/')[1]
                
            ecs_container = ecs_client.describe_tasks(cluster=cluster_details['clusters'][0]['clusterName'], tasks=[ecs_task['taskArns'][0].split('/')[1]])
            print "\t\t Name of the job running on container", ecs_container['tasks'][0]['containers'][0]['name']
            print "\t\t Container Instance Id for the given container:", ecs_container['tasks'][0]['containerInstanceArn']
                
            container_details = ecs_client.describe_container_instances(cluster=cluster_details['clusters'][0]['clusterName'], containerInstances=[ecs_container['tasks'][0]['containerInstanceArn']])
            print "\t\t\t CPU idle percentage for", ecs_container['tasks'][0]['containers'][0]['name'], ":", float(container_details['containerInstances'][0]['remainingResources'][0]['integerValue']) / float(container_details['containerInstances'][0]['registeredResources'][0]['integerValue'])
            print "\t\t\t MEM idle percentage for", ecs_container['tasks'][0]['containers'][0]['name'], ":", float(container_details['containerInstances'][0]['remainingResources'][1]['integerValue']) / float(container_details['containerInstances'][0]['registeredResources'][1]['integerValue'])
else:
    print "The cluster " + CLUSTER + " was not found. Make sure you are using correct cluster name and region."
    print "Nothing to do here for me. Exiting..."
    exit (1)    
