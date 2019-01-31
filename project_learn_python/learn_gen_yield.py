def reader():
        print 'Executing ::reader::'
	file = open('dummy.txt')
	for line in file:
		# print line
		yield line
	file.close


if __name__ == '__main__':
	# reader()
	# print next(reader())
	# print next(reader())
	mygen = reader()
        while True:
		print (next(mygen))
		# print (next(mygen))
	
