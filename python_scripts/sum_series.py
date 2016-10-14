import sys

i = 0
res = 0
while (i < 50 ):
	iput = sys.stdin.readline().rstrip('\n')
	if (iput == ''):
		break
	else:
		iput = int(iput)
		res = res + iput	
		i = i + 1

print res
