"""This was a challenge problem from LinkedIn
	It iterates over a range.
	If the number is divisible by 2; prints Linked.
	If the number is divisible by 3; prints In.
	If the number is divisible by both 2 and 3; it prints LinkedIn.
"""

print("Here comes the hotstepper...")	
print("Taking a range of 1 to 10")
for i in range (1, 11):
	if i % 6 == 0:
		print("LinkedIn")
	elif i % 3 == 0:
		print("In")
	elif i % 2 == 0:
		print("Linked")
	else:
		print(i)

	

