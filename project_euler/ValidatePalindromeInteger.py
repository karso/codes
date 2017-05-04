def isPalindrome(num):
  base = 1 
  rightDig = num % 10
  while (num / base > 10):
    base *= 10
  leftDig = num / base
  if (rightDig != leftDig):
    return False
  elif (num < 10):
    return True
  else:
    num %= base
    num /= 10
    return isPalindrome(num)
