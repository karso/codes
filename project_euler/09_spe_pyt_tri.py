# coding: utf-8
'''
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000 
'''
num1 = 1


while (num1 <= 995):
  num2 = num1 + 1
  while  (num2 <= 996):
    num3 = num2 + 1
    while (num1 + num2 + num3 <= 1000 ):
      if ((num3 * num3 == num1 * num1 + num2 * num2) and (num1 + num2 + num3 == 1000)):
        print "%d %d %d" % (num1, num2, num3)
        print num1 * num2 * num3
        exit()
      else:
        num3 = num3 + 1
    num2 += 1
  num1 += 1
