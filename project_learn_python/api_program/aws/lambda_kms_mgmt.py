import boto3

client = boto3.client('kms')

response1 = client.list_keys()

for keys in response1['Keys']:
    keyid = str(keys['KeyId'])
    try:
        response2 = client.describe_key(KeyId=keyid)
    except:
        continue            
    print response2
        
