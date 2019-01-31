import unittest
# from hello_world import hw
import hello_world

class TestHelloWorld(unittest.TestCase):
    '''    
    def setUp(self):
        self.thw = hw()
    '''    
    
    def test_hw(self):
        self.assertEqual(hello_world.hw(), "This is for unitTest")

    
if __name__ == '__main__':        
    unittest.main()        