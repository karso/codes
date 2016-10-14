import sys

#nums = raw_input()
nums = sys.argv[1:]
#print nums
#nums = map(int, nums.split(','))
print nums
nums.sort()
print nums
print nums[len(nums)-2]
