import sys
import socket

ip_list = sys.argv
ip_list.pop(0)
for ip in ip_list:
    km_if = ''
    mip = str(ip)
    print mip
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex((mip,9000))
    if result == 0:
        km_if = ip + ":9000"
        break
    else:
        print ('Now it works')
            


