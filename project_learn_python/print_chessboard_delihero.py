# The idea is to print a chess board of size nXn. In this board a 
# 'Black' square is represented as '0' and a 'White' square is represented as '1'.
# A 2X2 chessboard will look as follows

# 1 0
# 0 1

size = 4
i = 0
flag = 1

def change(num):
    if num == 1:
        num = 0
    else:
        num = 1
    
    return(num)

while i <= size * size - 1:
    if i % size == 0:
        row = []
    row.append(flag)
    flag = change(flag)
    if i % size == size - 1:
        print(row)
        flag = change(flag)
    i += 1