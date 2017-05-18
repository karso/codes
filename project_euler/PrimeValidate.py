import math

def isPrime(num):
  if (num < 1):
    print 'Invalid Input. Enter an integer greater than 0.'
    exit()
  elif (num == 1):
    print 'I think \'1\' is prime but not too sure. Use caution.'
    exit()
  elif (num == 2):
    return True
  elif (num % 2 == 0):
    return False
  else:
    sqrt = int(math.sqrt(num))
    for i in range(2, sqrt + 1):
      if (num % i == 0):
        return False
    return True
# print isPrime(29)
