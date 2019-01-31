'''
Take a decimal number, find its binary equivalent, 
reverse it and then find the decimal equivalent 
of the reversed number.
'''

def takeInput(num = None):
	if num == None:
		num = int(raw_input("Enter a number:" ))
	if not isinstance(num, int) or num <= 0:
		return "Please enter positive integer greater than 0"
	else:
		return num
	

def intToBin(num):
	arr = []
	while(num > 0):
		arr.append(num % 2)
		num = num / 2
	arr.reverse()	
	return arr

def reverseBin(binNum):
	binNum.reverse()
	return binNum

def binToInt(arr):
	num = int("".join(str(x) for x in arr),2)
	return num 

if __name__ == '__main__':
	num = takeInput()
	if isinstance(num, str):
		print num
		exit(1)
	binEq = intToBin(num)	
	binComp = reverseBin(binEq) 
	print binToInt(binComp)