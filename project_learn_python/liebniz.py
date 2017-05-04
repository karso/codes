num = int(raw_input())
res = 0

for i in range (0, num):
	if (i%2 == 0):
		j = 1
	else:
		j = -1
	res = res + round((1.0/(2*i + 1)), 15) * j
	#res = round(1.0, 15)/round((2*i + 1), 15)
	print res
print res
