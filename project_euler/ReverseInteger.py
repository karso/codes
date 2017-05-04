base = 0
def rev(num):
  if (type(num) != int):
    print "Invalid Input Type. Exiting..."
    print type(num)
    exit()
  elif (num < 10):
    return num
  else: 
   global base 
   base = 1
   nuNum = 0 
   while (num / (base * 10) > 0):
     base *= 10
   nuNum += ((num % 10) * base) + rev(num / 10)
   return nuNum

