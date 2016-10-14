from random import randint

board = []

for x in range(0, 5):
    board.append(["O"] * 5)

def print_board(board):
    for row in board:
        print " ".join(row)

def random_row(board):
    return randint(0, len(board) - 1)

def random_col(board):
    return randint(0, len(board[0]) - 1)

ship_row = random_row(board)
ship_col = random_col(board)

start = 0
end = 10
for turn in range(start, end):
	print "You have %d tries left" % (end - turn)
	g_row = int(raw_input("Guess Row Number:" ))
	g_col = int(raw_input("Guess Col Number:" ))
	if ((g_row < 0) and (g_row > 4)) or ((g_col < 0) and (g_col > 4)):
		print "Input out of range."
		print "It should be between 0 and 4"
		exit(1)
	
	if (g_row == ship_row) and (g_col == ship_col):
		board[g_row][g_col] = '*'
		print "You have found the ship"
		print print_board(board)
		exit(0)
	elif board[g_row][g_col] == 'X':
		print "This square is already taken"
		end = end + 1
		print "Try again"
	else:
		board[g_row][g_col] = 'X'
                print "Try again"
                print print_board(board)
		
