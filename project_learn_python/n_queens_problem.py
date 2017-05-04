"""This is a program to solve a particular case of N-Queens problem.
Here N is 8.
"""
N = 8
import numpy

#Define a board 8X8
board = [[0 for x in range (N)] for x in range (N)]
#board = numpy.zeros((8,8))
#board = [[0]*8]*8
#print board[3][3]
#exit(0)

#The position of the 1st queen will be defined.
#Let's hard code it for now.
location = [3, 3]

#We will calculate what are the squares that queen attacks and mark them blocked.
#First define queen's moves.
def queen_up(action, queen_at, board):
	x = queen_at[0]
	y = queen_at[1]
	while y < 7:
		y = y + 1
		board[x][y] = board[x][y] + 1*action
		
def queen_down(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while y > 0:
                y = y - 1
                board[x][y] = board[x][y] + 1*action


def queen_left(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while x > 0:
                x = x - 1
                board[x][y] = board[x][y] + 1*action

def queen_right(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while x < 7:
                x = x + 1
                board[x][y] = board[x][y] + 1*action

def queen_left_up(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while y < 7 and x > 0:
                y = y + 1
		x = x - 1
                board[x][y] = board[x][y] + 1*action

def queen_left_down(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while y > 0 and x > 0:
                y = y - 1
                x = x - 1
                board[x][y] = board[x][y] + 1*action
def queen_right_up(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while y < 7 and x < 7:
                y = y + 1
                x = x + 1
                board[x][y] = board[x][y] + 1*action
def queen_right_down(action, queen_at, board):
	x = queen_at[0]
        y = queen_at[1]
        while y > 0 and x < 7:
                y = y - 1
                x = x + 1
                board[x][y] = board[x][y] + 1*action
def put_queen_at(location, board):
	x = location[0]
        y = location[1]
        board[x][y] = board[x][y] + 99
	queen_up(1, location, board)
	queen_down(1, location, board)
	queen_left(1, location, board)
	queen_right(1, location, board)
	queen_left_up(1, location, board)
	queen_left_down(1, location, board)
	queen_right_up(1, location, board)
	queen_right_down(1, location, board)
#        print board
def remove_queen_from(location, board):
	x = location[0]
        y = location[1]
        board[x][y] = board[x][y] - 99
	queen_up(-1, location, board)
        queen_down(-1, location, board)
        queen_left(-1, location, board)
        queen_right(-1, location, board)
        queen_left_up(-1, location, board)
        queen_left_down(-1, location, board)
        queen_right_up(-1, location, board)
        queen_right_down(-1, location, board)
#	print board	

def mark_square_unusable(queen_at, board):
	x = queen_at[0]
	y = queen_at[1]
	board[x][y] = -99

def find_empty_square(board):
	for i in range(8):
		for j in range(8):
			if board[i][j] == 0:
				return i, j


#put_queen_at(location, board)
#print "========================"
#location2 = [3, 5]
#put_queen_at(location2, board)
#print "========================"
#remove_queen_from(location, board)
#print "========================"
#location3 = find_empty_square(board)
#put_queen_at(location3, board)
#print "========================"
#remove_queen_from(location3, board)
#print "========================"
#mark_square_unusable(location3, board)
#print location3
#print board[0][0]
#print "========================"
#location4 = find_empty_square(board)
#print location4
#exit(0)

def n_queen_algo(n, queen_at, board):
	if n == 0:
		return
	else:
		
		put_queen_at(queen_at, board)
		next_queen_at = find_empty_square(board)
		if next_queen_at:
			n_queen_algo(n-1, next_queen_at, board)
			return
			
		else:
			remove_queen_from(queen_at, board)
			mark_square_unusable(queen_at, board)
			repeat_queen_at = find_empty_square(board)
			if repeat_queen_at:
				n_queen_algo(n, repeat_queen_at, board)
				return
			else:	
				remove_queen_from(last_queen_at, board)
				mark_square_usable(queen_at, board)
				repeat_queen_at = find_empty_square(board)
				n_queen_algo(n, repeat_queen_at, board)
				return			
								

n_queen_algo(N, location, board)
print board
