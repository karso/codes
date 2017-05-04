"""Take a decimal number, find its binary equivalent, reverse it and then find the decimal equivalent of the reversed number"""

num = int(raw_input("Enter a number:" ))
ret = 0 
ind = 0
arr = [] 
while(num > 0):
	arr.append(num % 2)
	num = num / 2

while(ind < len(arr)):
	ret = ret + arr[ind] * pow(2, len(arr)-1-ind)
	ind = ind + 1
print arr
print ret
