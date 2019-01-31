import unittest
import complement_number

class TestComplementNumber(unittest.TestCase):
    '''
    Test for positive integer
    '''
    def test_takeInput(self):
        self.assertEqual(complement_number.takeInput(3.5), "Please enter positive integer greater than 0")

    '''
    Test edge case '0'
    '''
    def test_AllForZero(self):
        self.assertEqual(complement_number.takeInput(0), "Please enter positive integer greater than 0")
        
    '''
    Test Binary String generation
    '''
    def test_intToBin(self):
        self.assertEqual(complement_number.intToBin(6), [1, 1, 0])
    
    '''
    Test Reverse binary number
    '''
    def test_ReverseBin(self):
        self.assertEqual(complement_number.reverseBin([1, 1, 0, 1]), [1, 0, 1, 1])
        
    '''
    Test Decimal number creation
    '''
    def test_BinToInt(self):
        self.assertEqual(complement_number.binToInt([1, 0, 1, 0, 1, 0, 1, 0]), 170)

if __name__ == '__main__':
    unittest.main()