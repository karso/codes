#Factorial. Recursive algo

def fac(n):
	if n == 1 or n == 0:
		return 1
	elif n < 0:
		return "It has to be a positive integer"
		exit(1)
	elif isinstance(n, float):
		return "It has to be a positive integer"
		exit(1)
	else:
		return n * fac(n-1)
		
# print fac(4)

if __name__ == '__main__':
	print fac(4)