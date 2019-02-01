import boto3


def takeInput(num = None):
    if num == None:
        num = int(raw_input("Enter the AWS KMS Key Limit: ")) 
    if num <= 0 or not isinstance(num, int):
        return "Input must be positive integer greater than Zero."
    else:
        return num
        

def findUsage():
    kmsClient = boto3.client('kms')
    ####    ToDO: Catch connection exception
    kmsResponseListKeys = kmsClient.list_keys()
    usedKeys = len(kmsResponseListKeys['Keys'])
    return usedKeys

def perUsage(keyLimit, keyInuse):
    if keyLimit < keyInuse:
        return "Something is wrong! KeyUsage can't be higher than KeyLimit!"
    else:
        return (keyLimit - keyInuse) * 100 / keyLimit


if __name__ == '__main__':
    keyLimit = takeInput()
    if isinstance(keyLimit, str):
        print keyLimit
        exit(1)
    keyInuse = findUsage()
    print "Percentage of Available Keys is", perUsage(keyLimit, keyInuse)