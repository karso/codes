from math import factorial
turn = int(raw_input())
if (turn < 1 or turn > 50):
	print "Test cases should be between 1 and 50"
test_cases = []
while turn > 0:
	iput = float(raw_input())
	if (0 < iput < 10):
		sin = iput - pow(iput, 3)/factorial(3) + pow(iput, 5)/factorial(5) - pow(iput, 7)/factorial(7) + pow(iput, 9)/factorial(9)
		cos = 1 - pow(iput, 2)/factorial(2) + pow(iput, 4)/factorial(4) - pow(iput, 6)/factorial(6) + pow(iput, 8)/factorial(8)
		print sin
		print cos
		turn = turn - 1
	else:
		print "Input should be between 0 to 10"
	
