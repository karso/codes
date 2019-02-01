'''
Count the number of lines entered within the
same minute. Use 'bigfile.log'.
(LinkedIn)
'''

def getFreq(filename):
    freqTable = {}
    myfile = open(filename, 'r')
    for line in myfile:
        minit = line.split()[1][:5]
        if freqTable.has_key(minit):
            freqTable[minit] += 1
        else:
            freqTable[minit] = 1
            
    return freqTable            
    
if __name__=='__main__':
    freqMin = getFreq("bigfile.log")
    for keys, val in freqMin.iteritems():
        print keys, val
    