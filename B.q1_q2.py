#!/usr/bin/python

FileName = ("geneNames.txt")
data=file(FileName).readlines()
data.sort()

p_line = ""
list = []
for i in range(len(data)):
	if(data[i] == p_line):
		if not (p_line in list):
			list.append(p_line)
	else:
		p_line = data[i]

for n in list:
	print n,
