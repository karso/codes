'''
Count the number of keys in use.
Compare against an input value.
Return % usage
'''

import unittest
import kms_usage

class TestKMSUsage(unittest.TestCase):
    
    '''
    Test input value. It should be positive integer greater than Zero.
    '''
    def test_takeInput(self):
        self.assertEqual(kms_usage.takeInput(100), 100)
        self.assertEqual(kms_usage.takeInput(0),"Input must be positive integer greater than Zero.")
        self.assertEqual(kms_usage.takeInput(3.5),"Input must be positive integer greater than Zero.")
        self.assertEqual(kms_usage.takeInput(-5),"Input must be positive integer greater than Zero.")
    
    
    
    '''
    Test connection to AWS API. Test the count.
    '''
    def test_findUsage(self):
        self.assertIsInstance(kms_usage.findUsage(), int)
    
    '''
    Test comparison module.
    '''
    def test_perUsage(self):
        self.assertEqual(kms_usage.perUsage(10, 3), 70)
        self.assertEqual(kms_usage.perUsage(10, 0), 100)
        self.assertEqual(kms_usage.perUsage(10, 10), 0)
        self.assertEqual(kms_usage.perUsage(10, 12), "Something is wrong! KeyUsage can't be higher than KeyLimit!")
    
    
    
    
if __name__ == '__main__':
    unittest.main()    