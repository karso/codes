''' 
# python haproxy_log_parser.py [haproxy log file location] [time in seconds] [method]
# e.g.: 
# python haproxy_log_parser.py /var/log/haproxy.log 300 min_response_time 
#
# The above command will return the minimum response time since last 300 seconds as captured in /var/log/haproxy.log.
#
# Currently the following methods are supported:
# - min_response_time: Returns the minimum response time since last n secods.
# - max_response_time: Returns the maximum response time since last n secods.
# - avg_response_time: Returns the average response time since last n secods.
# - request_rate: Returns incoming request rate in seconds last n seconds.
# - bytes_rate:  Returns outgoing bytes rate in seconds last n seconds.
'''

import sys

def usage():
    print "python haproxy_log_parser.py [haproxy log file location] [time in seconds] [method]"
    print "Supported Methods"
    print "1. min_response_time"
    print "2. max_response_time"
    print "3. avg_response_time"
    print "4. request_rate"
    print "5. bytes_rate"
    return 0

def takeInput(logfile = None, duration = None, method = None):
    
    if len(sys.argv) != 4 and (logfile == None or duration == None or method == None):
        print "Exactly 3 inputs required in the following order."
        print "[haproxy log file location] [time in seconds] [method]"
        print "Please correct and try again"
        print "================"
        return usage()
    elif len(sys.argv) == 4: 
        if (not isinstance(sys.argv[1], str) or not isinstance(sys.argv[2], int) or not isinstance(sys.argv[3], str)):
            return usage()
        else:
            return sys.argv[:1]
    else:
        if (not isinstance(logfile, str) or not isinstance(duration, int) or not isinstance(method, str)):
            return usage()
        else:
            return [logfile, duration, method]    

def minResponseTime():
    return 0.0

def maxResponseTime():
    return 0.0

def avgResponseTime():
    return 0.0

def requestRate():
    return 0.0

def byteRate():
    return 0.0

        
def callMethod(userInput):
    methodsMap = {'min_response_time' : minResponseTime,
                 'max_response_time' : maxResponseTime,
                 'avg_response_time' : avgResponseTime, 
                 'request_rate' : requestRate,
                 'bytes_rate' : byteRate }
    
    try:
        methodName = methodsMap[userInput[2]]
    except:
        return usage()  
        exit(1)
    return methodName()



if __name__ == '__main__':
    userInput = takeInput()
    print callMethod(userInput)