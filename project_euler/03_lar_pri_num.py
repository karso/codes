'''
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
'''
import math
import PrimeValidate

bigNum = 600851475143
bigNumSqrt = int(math.floor(math.sqrt(bigNum))) - 1
hiEnd = bigNumSqrt
while (hiEnd > 2):
  if (bigNum % hiEnd == 0) and PrimeValidate.isPrime(hiEnd): 
    print hiEnd
    break
  else:
    hiEnd -= 1
