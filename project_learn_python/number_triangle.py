'''
Print a number triangle as follows
1 
1 2 
1 2 3 
1 2 3 4 
1 2 3 4 5  
'''

i = 1
while i <= 5:
    j = 1
    line = ''
    while j <= i:
            line += str(j) + ' '
            j += 1
    print line
    i += 1
