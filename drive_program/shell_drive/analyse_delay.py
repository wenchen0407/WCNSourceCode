#!/usr/bin/python

import sys
import os

E=[37, 38, 41, 44, 47, 50, 53, 56, 58, 70, 74, 76, 81, 86, 91, 96, 101, 106, 109, 120, 126, 129, 136, 143, 150, 157, 164, 171, 188, 193, 197]

filename=sys.argv[1]
filename1=sys.argv[2]
write_delay=sys.argv[3]
write_energy=sys.argv[4]
#theta=float(sys.argv[5])

if os.path.exists(write_delay):
    os.remove(write_delay)
else:
    print("Sorry, I can not remove %s file." % write_delay)
	
if os.path.exists(write_energy):
    os.remove(write_energy)
else:
    print("Sorry, I can not remove %s file." % write_energy)

f=open(filename, "r")
f1=open(filename1, "r")

f_w1=open(write_delay, "a")
f_w2=open(write_energy, "a")

lines=f.readlines()
node_lines=f1.readlines()

last_delay=0.0
curr_delay=0.0

avgnh=0.0

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
		if org_delay!=0.2 and org_delay!=0.3 and org_delay!=0.4 and org_delay!=0.5:
			last_delay=(int(org_delay/0.1)+1)*0.1
		else:
			last_delay=org_delay
		curr_delay=last_delay
	else:
		tokens=line.split(',')
		isreceived=int(tokens[1])
		org_delay=float(tokens[4])
		if isreceived == 1:
			if org_delay!=0.2 and org_delay!=0.3 and org_delay!=0.4 and org_delay!=0.5:
				last_delay=(int(org_delay/0.1)+1)*0.1
			else:
				last_delay=org_delay
			curr_delay=last_delay
		else:
			curr_delay=last_delay+0.1
			last_delay=last_delay+0.1
	energy=curr_node+E[curr_node-20]
	#energy=(8640/(energy*0.02*1.2*0.001))/(60*60*24)
	energy=(8640*curr_node/(energy*0.02*1.5*0.005))/(60*60*24)
	f_w1.write(str(curr_delay))
	f_w1.write('\n')
	f_w2.write(str(energy))
	f_w2.write('\n')
	i += 1
f_w1.close()
f_w2.close()

