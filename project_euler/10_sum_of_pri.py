'''
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million (2000000).
'''
import PrimeValidate

i = 2
limit = 2000000
sum = 0
while (i < limit):
  if (PrimeValidate.isPrime(i)): 
    sum += i
  i += 1
print sum

