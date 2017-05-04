n = int(raw_input())
N = raw_input()
numlist = map(int, N.split(" "))
numlist.sort()
for i in range(0, n-1):
	if (numlist[i] == numlist[i+1]):
		numlist[i] = 0
numlist.sort()
print numlist[len(numlist)-2]
