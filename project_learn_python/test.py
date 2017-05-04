import sys
buffer = []
while True:
    userinput = sys.stdin.readline().rstrip('\n')
    if userinput == '':
        break
    else:
        buffer.append(userinput)
print buffer
