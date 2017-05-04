'''
# 2520 is the smallest number that can be divided by each of the numbers from 1
# to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the
# numbers from 1 to 20?
'''
LIMIT = 20
divsor = 2
prod = 1
numArr = []
for i in range(0,LIMIT): 
  numArr.append(i+1)

oneCount = 0 
while (oneCount < LIMIT):
  oneCount = 0
  index = 0 
  divd = 0
  while (index < LIMIT):
    if (numArr[index] == 1):
      oneCount += 1
    elif (numArr[index] % divsor == 0):
      numArr[index] /= divsor 
      divd += 1
    index += 1
  if (divd == 0): 
    divsor += 1
  else:
    prod *= divsor

print prod
