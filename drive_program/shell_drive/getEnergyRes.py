#!/usr/bin/python

import sys
import statistics
from array import array

filename_r=sys.argv[1]
filename_w=sys.argv[2]
scheme=sys.argv[3]
lp=sys.argv[4]
add_method=sys.argv[5]
startnode=sys.argv[6]

print (scheme)

f_r=open(filename_r, "r")

lines=f_r.readlines()
dr_arr=[0.0]*20
delay_arr=[0.0]*20
node_arr=[0.0]*20
dr=0.0
delay=0.0
node=0.0

count=0
for line in lines:
	tokens=line.split('\t')
	dr+=float(tokens[0])
	delay+=float(tokens[1])
	#node+=float(tokens[2])
	dr_arr[count]=float(tokens[0])
	delay_arr[count]=float(tokens[1])
	#node_arr[count]=float(tokens[2])
	count+=1
f_r.close()
dr=dr/count
delay=delay/count
#node=node/count
print (dr_arr)
print (delay_arr)
#print (node)
dr_stdv=statistics.stdev(dr_arr)
delay_stdv=statistics.stdev(delay_arr)
#node_stdv=statistics.stdev(node_arr)
print (dr_stdv)
print (delay_stdv)
#print (node_stdv)

f_w=open(filename_w, "a")
f_w.write(scheme)
f_w.write('\t')
f_w.write(lp)
f_w.write('\t')
f_w.write(add_method)
f_w.write('\t')
f_w.write(startnode)
f_w.write('\t')
f_w.write(str(dr))
f_w.write('\t')
f_w.write(str(dr_stdv))
f_w.write('\t')
f_w.write(str(delay))
f_w.write('\t')
f_w.write(str(delay_stdv))
f_w.write('\n')
f_w.close()