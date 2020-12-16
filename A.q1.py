#!/usr/bin/python

# Question 1 results can be achieved in the following simpler way
# import randint library
from random import randint
def foo(length):	# Define a subroutine
	list = []
	is_done = False
	while(is_done == False):
		r = randint(1,length)
		if not(r in list):
			list.append(r)

		if (len(list) == length):
			is_done = True
	return list

x = foo(10)	# Call foo subroutine
print x
