import unittest
import haproxy_log_parser

class TestHAProxyLogParser(unittest.TestCase):
    
    def test_takeInput(self):
        self.assertEqual(haproxy_log_parser.takeInput('/tmp/somename', 300, 'my_method'), ['/tmp/somename', 300, 'my_method'])
        self.assertEqual(haproxy_log_parser.takeInput('/tmp/somename', 'my_method'), 0)
        self.assertEqual(haproxy_log_parser.takeInput('/tmp/somename', 'my_method', 300), 0)

    def test_callMethod(self):
        self.assertIsInstance((haproxy_log_parser.callMethod(['/tmp/somename', 300, 'min_response_time'])), float)
        self.assertEqual((haproxy_log_parser.callMethod(['/tmp/somename', 300, 'min'])), 0)

    def test_minResponseTime(self):
        pass
    
    def test_maxResponseTime(self):
        pass
    
    def test_avgResponseTime(self):
        pass
    
    def test_requestRate(self):
        pass
    
    def test_byteRate(self):
        pass
    
    
    
    
if __name__ == '__main__':
    unittest.main()    