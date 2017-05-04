# -*- coding: utf-8 -*-

# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

# What is the 10001st prime number?

import PrimeValidate

cntr = 1
num = 1
while (cntr < 10001):
  num += 1
  if (PrimeValidate.isPrime(num)):
    cntr += 1
print num
