#!/usr/bin/python

import sys
import os

E=[37, 38, 41, 44, 47, 50, 53, 56, 58, 70, 74, 76, 81, 86, 91, 96, 101, 106, 109, 120, 126, 129, 136, 143, 150, 157, 164, 171, 188, 193, 197]

filename=sys.argv[1]
filename1=sys.argv[2]
write_nh=sys.argv[3]
write_costF=sys.argv[4]
theta=float(sys.argv[5])

if os.path.exists(write_nh):
    os.remove(write_nh)
else:
    print("Sorry, I can not remove %s file." % write_nh)
	
if os.path.exists(write_costF):
    os.remove(write_costF)
else:
    print("Sorry, I can not remove %s file." % write_costF)

f=open(filename, "r")
f1=open(filename1, "r")

f_w1=open(write_nh, "a")
f_w2=open(write_costF, "a")

lines=f.readlines()
node_lines=f1.readlines()

last_delay=0.0
curr_delay=0.0

avgnh=0.0

p1=-0.7141
p2=-0.1383
p3=0.3305

node_line_cont=0
#curr_counter=0
curr_node=20
next_node=int((node_lines[node_line_cont].split())[1])
next_counter=int((node_lines[node_line_cont].split())[0])
i=0

for line in lines:
	if i == next_counter-1:
		curr_node=next_node
		node_line_cont += 1
		if node_line_cont < len(node_lines):
			next_node=int(node_lines[node_line_cont].split()[1])
			next_counter=int(node_lines[node_line_cont].split()[0])
	if i==0:
		isreceived=1
		tokens=line.split(',')
		org_delay=float(tokens[4])
		curr_delay=org_delay
		last_delay=curr_delay
	else:
		tokens=line.split(',')
		isreceived=int(tokens[1])
		org_delay=float(tokens[4])
		if isreceived == 1:
			curr_delay=org_delay
		else:
			curr_delay=org_delay+last_delay
		last_delay=curr_delay
	nh=p1*curr_delay*curr_delay+p2*curr_delay+p3
	costF=nh*(-1.0)+theta*(curr_node+E[curr_node-20])
	f_w1.write(str(nh))
	f_w1.write('\n')
	f_w2.write(str(costF))
	f_w2.write('\n')
	i += 1
	#print curr_delay, nh
	#avgnh += nh
f_w1.close()
f_w2.close()

