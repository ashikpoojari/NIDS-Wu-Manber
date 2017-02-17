#!/usr/bin/python
import os,sys
import string
import numpy as np
import os,binascii
import matplotlib.pyplot as plt

key=4
dirConst= os.getcwd()

file=open(dirConst+'/fullsignatures.txt','r')

len_lst=[]
a=[]
a_min = None
j=0

for line in file:
	if(j < 16348):
		len_lst.append(len(line))
		if(len(line) < a_min or a_min is None):
			a_min = len(line)
		a.append(line)
		j=j+1

file.close()
a_min=a_min-1
print(a_min)

file = open('patterns.txt','w')
# j=0
# for l in range(0,len(a)/key):
# 	s=''
# 	for i in range(0,key):
# 		# print(l*key+i)
# 		s=s+a[l*key+i][:a_min]
# 	file.write('pattern['+str(j)+'] <='+str(4*len(s))+'\'h'+s+';\n')
# 	j=j+1


patternlist=[]

for item in a:
	tmplist=patternlist
	appendlist= True
	for i in tmplist:
		if(i == item[:((a_min/4)*4)]):
			appendlist = False
			break
	if appendlist:
		patternlist.append(item[:((a_min/4)*4)])


for item in patternlist:
	file.write(item+'\n')
	# file.write(item[:3]+'\n')

file.close()


file = open('input.txt','w')

for l in range(0,80):
	file.write(binascii.b2a_hex(os.urandom(64))+'\n')

file.close()


file = open('signature16348.txt','w')
j=0
for l in range(0,len(a)):
	file.write(a[j])
	j=j+1


# the histogram of the data
plt.hist(len_lst,100,facecolor='green')
plt.xlabel('signatures')
plt.ylabel('lengths')
plt.grid(True)

plt.show()