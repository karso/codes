#!/usr/bin/python

####	********************************************************************************************************************************	####    
####	Using p022_names.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. 		####
####	Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain 		####
####	a name score.																####
####	For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, 				####
####	is the 938th name in the list. So, COLIN would obtain a score of 938 X 53 = 49714.							####
####	What is the total of all the name scores in the file?											####
####	********************************************************************************************************************************     	####    

import string


def nameScore(name):
	score = 0
	namecharlist = list(name)
	for char in namecharlist:
		score += string.uppercase.index(char) + 1
	return score


namefile = open("p022_names.txt", "r")
namelist = namefile.read().replace('"','').split(",")
namelist.sort()

pos = 0
tot_score = 0

for name in namelist:
        pos += 1
	tot_score += pos * nameScore(name)

	if name == "COLIN":
		print pos * nameScore(name)


print tot_score
