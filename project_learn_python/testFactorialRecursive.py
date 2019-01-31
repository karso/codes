import unittest
import factorial_recursive

class TestFactorialRecursive(unittest.TestCase):
    def test_fac(self):
        self.assertEqual(factorial_recursive.fac(5), 120)
     
    def test_facZero(self):
        self.assertEqual(factorial_recursive.fac(0), 1)
        
    def test_facNegative(self):
        self.assertEqual(factorial_recursive.fac(-1), "It has to be a positive integer", "A negative number is sent")
        
    def test_facFloat(self):
        self.assertEqual(factorial_recursive.fac(3.5), "It has to be a positive integer", "A float is sent")         

if __name__ == '__main__':
    unittest.main()        