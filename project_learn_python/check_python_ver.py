import sys
sys.version_info  
version = ".".join(map(str, sys.version_info[:2]))
if float(version) >= 2.7:
    print 'OK'
else:
    print 'KO'

