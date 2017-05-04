'''
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 X 99.
Find the largest palindrome made from the product of two 3-digit numbers.
'''

##############################################################
# Algo: Start from the highest product of two 3-dig numbers. # 
# Go in reverse order and check if it is palindrome.         #
# Check if it is prime. first such non-prime number is ans.  #
##############################################################


import ReverseInteger

hiEnd = 999
limit = int(hiEnd / 10)
hiPal = 0

while (hiEnd > limit):
  loEnd = hiEnd - 1
  while (loEnd > limit):
    product = hiEnd * loEnd
    if (product == ReverseInteger.rev(product)) and product > hiPal:
     hiPal = product
    else:
      loEnd -= 1
  hiEnd -= 1
print hiPal
