"""This method of finding duplicates work only if you know the range of numbers"""


arr = [0 for x in range(1000)]
while (1):
	num = int(raw_input())
	arr[num] = arr[num] + 1
	if (arr[num] > 1):
		print num
		break

	
