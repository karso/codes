#!/usr/bin/python


####	************************************************************************************    ####
####	The number, 197, is called a circular prime because all rotations of the digits: 	####
####	197, 971, and 719, are themselves prime.						####
####	There are thirteen such primes below 100: 						####
####	2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.					####
####	How many circular primes are there below one million (1000000)?				####
####	************************************************************************************    ####

####	****	Works Partially. DEBUG	****	####
####################################################

LIMIT = 100
count = 0 

def isPrime (n):
	'''check if integer n is a prime'''
    	# make sure n is a positive integer
    	n = abs(int(n))
    	# 0 and 1 are not primes
    	if n < 2:
        	return False
    	# 2 is the only even prime number
    	if n == 2: 
        	return True    
    	# all other even numbers are not primes
    	if not n & 1: 
        	return False
    	# range starts with 3 and only needs to go up the squareroot of n
    	# for all odd numbers
    	for x in range(3, int(n**0.5)+1, 2):
        	if n % x == 0:
            		return False
    	return True


def numToDigs(num):
	digs = []
	while num > 10:
		digs.append(num % 10)
		num -= num % 10
		num = num / 10
	digs.append(num)
	return digs


def rotate(num):
	tempNum = num
	tempList = []
	while tempNum > 9:
		tempList.append(tempNum % 10)
		tempNum -= tempNum % 10
		tempNum /= 10
	tempList.append(tempNum)
	return int(''.join(str(i) for i in tempList))


def allRotations(num):
	rotList = []
	rotList.append(num)
	# from itertools import permutations
	# perms = [a for a in permutations(digList)]
	nuNum = 0

	while nuNum != rotList[0]:
		nuNum = rotate(num)
		rotList.append(nuNum)
		num = nuNum
	print rotList		
	return rotList
	

for num in range (1, LIMIT+1):
	if isPrime(num):
		print "Doing #", num
		rotList = allRotations(num)
		flag = 1
		for priNum in rotList:
			print "priNum = ", priNum
			if isPrime(priNum):
				flag = 1
			else:
				flag = 0
				break
		
		print "Flag = ", flag
		print "Count = ", count
		if flag == 1:
			count += 1


print count
