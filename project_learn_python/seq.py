import sys
if len(sys.argv[1:]) == 1:
	iput = sys.argv[1]
	iput = int(iput)
	for i in range(1, iput+1):
		print i
elif len(sys.argv[1:]) == 2:
	iput1 = sys.argv[1]
        iput1 = int(iput1)
	iput2 = sys.argv[2]
        iput2 = int(iput2)
	if iput1 <= iput2:
		while iput1 <= iput2:
			print iput1
			iput1 = iput1 + 1
	else: 
		while(iput2 <= iput1):
			print iput1
			iput1 = iput1 - 1 

elif len(sys.argv[1:]) == 3:
	iput1 = sys.argv[1]
        iput1 = int(iput1)
        iput2 = sys.argv[2]
        iput2 = int(iput2)
	iput3 = sys.argv[3]
        iput3 = int(iput3)
	if iput1 < iput3:
		while iput1 < iput3:
                	print iput1
			iput1 = iput1 + iput2
	else:
		while iput3 < iput1:
			print iput1
			iput1 = iput1 + iput2

else:
	print "Invalid number of arguements"
