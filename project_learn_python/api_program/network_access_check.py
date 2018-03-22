'''
We need to run a script in a Jenkins job that does the network access checks from the Oracle hosted Jenkins slave. 
Below are the access checks the script should verify when it runs on the slave. 
The script should output the list of successful and failed checks. Below are the operations we should verify:
1. Read from an S3 bucket in US-EAST-1.
2. Write a 500MB object to S3 bucket in US-EAST-1.
3. HTTPS GET & PUT requests to an external ELB in US-EAST-1.
4. HTTPS GET & PUT access to registry.hub.docker.com. 
5. Download packages from NPM repositories.
6. Download Jar files from maven central repositories.
'''

import boto3
import docker
import subprocess
import random, string
import os
import logging
from datetime import datetime

logging.basicConfig(level=logging.INFO)
logging.info('Starting Network Access Check...')


FILE_SIZE = 1 # in MB
BUCKET_NAME = 'vimruls-bucket'
UPLOAD_FNAME = 'test_s3upload_' + datetime.today().strftime("%m%d%Y")
IMAGE_NAME = 'cloudritydevops/soukar-test:' + datetime.today().strftime("%m%d%Y")

### Create a file (500M size) locally and upload to S3 Bucket
def s3_put():
    logging.info('1. Checking write to S3 bucket')

    random_file_size = FILE_SIZE
    bucket_name = BUCKET_NAME
    upload_file_name = UPLOAD_FNAME
    random_file_at = '/tmp/' + ''.join(random.choice(string.lowercase) for x in range(6)) + datetime.today().strftime("%m%d%Y")


# Creating the file locally
    try:
        logging.info('Creating a file of size ' + str(random_file_size) + 'MB')
        fd = open(random_file_at, "wb")
        size =  random_file_size * 1024 * 1024
        fd.write("\0" * size)
        fd.close()
    except StandardError as e:
        logging.fatal('Error creating the file on local FS')
        logging.fatal(e)
        raise Exception('FATAL: S3 upload failed. See logs for more detail.')
    # Uploading the file to S3 bucket
    try:
        logging.info('Uploading the file to S3 bucket ' + bucket_name)
        s3_upload = boto3.resource('s3')
        s3_upload.meta.client.upload_file(random_file_at, bucket_name, upload_file_name)
    except StandardError as e:
        logging.fatal('Error uploading the test file to S3 bucket')
        logging.fatal(e)
        raise Exception('FATAL: S3 upload failed. See logs for more detail.')
    # Removing the file from local FS
    logging.info('Removing the file from local FS')
    try:
        os.remove(random_file_at)
    except StandardError as e:
        logging.warning('The file could not be removed from local FS')
    logging.info('Write to S3 bucket successful!')    
          
def s3_get(): 
    
    bucket_name = BUCKET_NAME
    upload_file_name = UPLOAD_FNAME
    download_file_to = '/tmp/test_s3download_' + datetime.today().strftime("%m%d%Y")
    
    ### Reading objects in S3 bucket
    try:
        logging.info('2. Checking read from S3 bucket')
        logging.info('Looking for an object in the S3 bucket ' + bucket_name + '. We will take the first object we find.')
        client = boto3.client('s3')
        response = client.list_objects(Bucket=bucket_name)
        obj_name = response['Contents'][0]['Key']
    except StandardError as e:
        logging.fatal('Error connecting to S3 bucket to get object list')
        raise Exception ('FATAL: Could not fetch object list')    

    ### Download the object from S3 Bucket
    try:
        logging.info('Downloading the object ' + obj_name + ' from ' + bucket_name)
        s3 = boto3.resource('s3')
        s3.meta.client.download_file(bucket_name, obj_name, download_file_to)
    except StandardError as e:
        logging.fatal('Error downloading object from S3')
        raise Exception ('FATAL: Could not download object')    
    logging.info('Removing the downloaded object ' + download_file_to + ' from local FS')
    
    ### Remove the object from local FS
    try:
        os.remove(download_file_to)
    except StandardError as e:
        logging.warning('The file could not be removed from local FS')        

    ### Remove the object from S3 bucket
    logging.info('Removing the object ' + upload_file_name + ' from S3 bucket ' + bucket_name)
    try:
        response = client.delete_object(Bucket=bucket_name, Key=obj_name)
    except StandardError as e:
        logging.warning('The file could not be removed from S3')
    logging.info('Read from S3 bucket successful!')    

# def docker_get():    
    # Do a docker pull from command line
def docker_put():
    # Do a docker push from command line
    logging.info('3. Checking write to dockerhub')
    # Create a Dockerfile. Expect ubuntu:14.0.4 to be present locally.
    try:
        fd = open('Dockerfile', 'wb')
        fd.write('FROM ubuntu:14.04.4')
        fd.close()
    except StandardError as e:
        logging.fatal('Error creating dockerfile.')
        raise Exception('FATAL: Docker put failed.')    
    # Create an image and push it to docker hub 
    try:
        subprocess.call(['docker', 'build', '-t', IMAGE_NAME, '.'])      
        subprocess.call(['docker', 'push', IMAGE_NAME])
    except StandardError as e:
        logging.fatal('Error executing docker command')
        raise Exception('FATAL: Docker put failed.')
    
# def elb_get():
    # Do a http get

# def npm_get():
    # Do a http get as done in apprity build job 

# def maven_get():
    # Do a http get as done in apprity build job   

### TODO ###
############
# Keep testing


# s3_put()
# s3_get()
# docker_get()
docker_put()
