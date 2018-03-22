#!/usr/bin/python

import boto3
import sys
   

def usage():
    print "python", sys.argv[0], "[region]", "[cluster]", "[service_name]", "[container_name]", "[resource]", "[threshold]"
    exit (1)

try: 
    REGION = sys.argv[1]
    CLUSTER = sys.argv[2]
    SERVICENAME = sys.argv[3]
    CONTAINER = sys.argv[4]
    RESOURCE = sys.argv[5]
    THRESHOLD = sys.argv[6]
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
            
        ecs_service = ecs_client.list_services(cluster=cluster_details['clusters'][0]['clusterName'])
        # print "The cluster", cluster_details['clusters'][0]['clusterName'], "has the following services"
        for service in ecs_service['serviceArns']:
            # print "Service Name:", service.split('/')[1]
            if service.split('/')[1] == SERVICENAME:
                service_found = True
                ecs_task_def = ecs_client.describe_services(cluster=cluster_details['clusters'][0]['clusterName'], services=[service])
                # print "\t Task Definition:", ecs_task_def['services'][0]['taskDefinition'].split('/')[1]
                
                ecs_task = ecs_client.list_tasks(cluster=cluster_details['clusters'][0]['clusterName'], serviceName=service.split('/')[1])
                # print "\t Task ID:", ecs_task['taskArns'][0].split('/')[1]
                
                ecs_container = ecs_client.describe_tasks(cluster=cluster_details['clusters'][0]['clusterName'], tasks=[ecs_task['taskArns'][0].split('/')[1]])
                # print ecs_container['tasks'][0]['containers']
                for container in ecs_container['tasks'][0]['containers']:
                    if container['name'] == CONTAINER:
                        container_found = True
                        # print "\t\t Name of the job running on container", ecs_container['tasks'][0]['containers'][0]['name']
                        # print "\t\t Container Instance Id for the given container:", ecs_container['tasks'][0]['containerInstanceArn']
                
                        container_details = ecs_client.describe_container_instances(cluster=cluster_details['clusters'][0]['clusterName'], containerInstances=[ecs_container['tasks'][0]['containerInstanceArn']])
                        # print container_details
                        if RESOURCE == 'CPU':
                            # print "\t\t\t CPU idle percentage for", container['name'], ":", float(container_details['containerInstances'][0]['remainingResources'][0]['integerValue']) / float(container_details['containerInstances'][0]['registeredResources'][0]['integerValue'])
                            per_use = int((float(container_details['containerInstances'][0]['registeredResources'][0]['integerValue']) - float(container_details['containerInstances'][0]['remainingResources'][0]['integerValue'])) / float(container_details['containerInstances'][0]['registeredResources'][0]['integerValue']) * 100)
                        elif RESOURCE == 'MEM':
                            # print "\t\t\t MEM idle percentage for", container['name'], ":", float(container_details['containerInstances'][0]['remainingResources'][1]['integerValue']) / float(container_details['containerInstances'][0]['registeredResources'][1]['integerValue'])
                            per_use = int((float(container_details['containerInstances'][0]['registeredResources'][1]['integerValue']) - float(container_details['containerInstances'][0]['remainingResources'][1]['integerValue'])) / float(container_details['containerInstances'][0]['registeredResources'][1]['integerValue']) * 100)
                        else:
                            print "The resource type " + RESOURCE + " is not supported. Please retry with [CPU|MEM]. Exiting..."
                            exit (1)  
                        # print per_use     
                        if per_use > int(THRESHOLD):
                            ecs_inst_id = container_details['containerInstances'][0]['ec2InstanceId']
                            client = boto3.client('ec2', region_name=REGION)
                            response = client.describe_instances(InstanceIds=[ecs_inst_id])
                            # print ecs_inst_id    
                            print response['Reservations'][0]['Instances'][0]['PrivateIpAddress']
                        break  
                    else:
                        container_found = False
                if not container_found:
                    print "The container " + CONTAINER + " was not found. Nothing for me to do. Exiting..."
                    exit (1)  
                break
            else: 
                service_found = False
        if not service_found:
            print "The service " + SERVICENAME + " was not found. Nothing for me to do. Exiting..."
            exit (1)
    else:
        print "The cluster " + CLUSTER + " was found inactive. Nothing for me to do. Exiting..."
        exit (1)                   
else:
    print "The cluster " + CLUSTER + " was not found. Make sure you are using correct cluster name"
    print "Nothing to do here for me. Exiting..."
    exit (1)    

    