X = 1
Y = 1
Z = 1
N = 2

arr = []
for x in range (0,X+1):
	for y in range (0,Y+1):
		for z in range (0,Z+1):
			if (x+y+z != N):
				a = []
				a.append(x)
				a.append(y)
				a.append(z)
				arr.append(a)

print arr
