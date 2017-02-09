#!/usr/bin/env python
from TOSSIM import Tossim
from random import *
from TestNetworkMsg import *
import sys
#import socket
import os
import time
import os.path
import numpy as np
from subprocess import call
import random
import collections


enable_main=1
if enable_main:
	def main():
		rssi_level=sys.argv[1]
		fault_seed=sys.argv[2]
		faultModel = sys.argv[3]
		return {'y0':rssi_level, 'y1':fault_seed, 'y2':faultModel}
	rssi_level=float(main()['y0'])
	fault_seed=int(main()['y1'])
	faultModel=main()['y2']
else:
	rssi_level=-20;

t = Tossim([])
t.addChannel('printf', sys.stdout)
t.addChannel("DataFeedback", sys.stdout)
r = t.radio()



def initialize_network():

	# this is topology for channel 26
	f = open("topo.txt", "r")

	#wireless rssi topology injection & model establishment
	lines = f.readlines()
	#initialize schedule
	L_topo=list()
	L_topo.append(0)
	topo=lines[0].split()
	for topo_node in topo:
	    L_topo.append(int(topo_node))

	#print "L_topo: ", L_topo
	for channel_1 in [22, 23, 24, 25, 26]:
		channel=channel_1
		rssi_strength=rssi_level
		neignbour_strength=100
		sync_rssi_strength=100
		
		#for sender in range(1, 51):
		#	for receiver in range(1, 51):
		#		r.add(sender, receiver, float(neignbour_strength), channel_1)

		for i in range(1, len(lines)-1):
		    nodes_pre = lines[i].split()
		    nodes_post = lines[i+1].split()
		    for node1 in nodes_pre:
		        r.add(int(node1), 0, float(sync_rssi_strength), channel)
		        r.add(0, int(node1), float(sync_rssi_strength), channel)
		        #print "( "+str(node1)+", "+"0 )"+" rssi_level: "+str(float(sync_rssi_strength))
		        #schedule[i][j]=int(node1)
		        for node2 in nodes_post:
		            if i<len(lines)-2:
		                r.add(int(node1), int(node2), float(rssi_level), channel)
		                r.add(int(node2), int(node1), float(rssi_level), channel)
		            else:
		                r.add(int(node1), int(node2), float(neignbour_strength), channel)
		                r.add(int(node2), int(node1), float(neignbour_strength), channel)		            	
		                #print "( "+str(node1)+", "+str(node2)+" )"+" rssi_level: "+str(float(neignbour_strength))
		                #print "( "+str(node2)+", "+str(node1)+" )"+" rssi_level: "+str(float(neignbour_strength))

		for node in lines[len(lines)-1].split():
			r.add(int(node), 0, float(sync_rssi_strength), channel)
			r.add(0, int(node), float(sync_rssi_strength), channel)
			#print "( "+str(node)+", "+"0 )"+" rssi_level: "+str(float(sync_rssi_strength))
		i=0
		for line in lines:
		    if i!=0:
		        ns = line.split()
		        for n in ns:
		            for sibling in ns:
		                if int(n)!=int(sibling):
		                    r.add(int(n), int(sibling), float(neignbour_strength), channel)
		                    r.add(int(sibling), int(n), float(neignbour_strength), channel)
		                    #print "( "+str(n)+", "+str(sibling)+" )"+" rssi_level: "+str(float(-10))
		                    #print "( "+str(sibling)+", "+str(n)+" )"+" rssi_level: "+str(float(-10))
		    i=i+1
		for sensor in range(1, 51):
			r.add(sensor, 0, float(sync_rssi_strength), channel_1)
			r.add(0, sensor, float(sync_rssi_strength), channel_1)

	
	for node in range(0, 51):
		m = t.getNode(node);
		for channel in [22, 23, 24, 25, 26]:
			if channel==22:
				noise = open("noise_chan22_110.txt", "r")
				lines = noise.readlines()
				#print lines
			elif channel==23:
				noise = open("noise_chan23_110.txt", "r")
				lines = noise.readlines()
			elif channel==24:
				noise = open("noise_chan24_110.txt", "r")
				lines = noise.readlines()
			elif channel==25:
				noise = open("noise_chan25_110.txt", "r")
				lines = noise.readlines()
			elif channel==26:
				noise = open("noise_chan26_110.txt", "r")
				lines = noise.readlines()
				#print lines
			for line in lines:
				strrr = line.strip()
				if (strrr != ""):
					val = int(strrr)
					m.addNoiseTraceReading(val, channel)
			m.createNoiseModel(channel);
		#print "hello"
		m.turnOn()
		#print "hello2"
		m.bootAtTime(0)
		#print "Booting ", node, " at time ", str(0)
	return len(topo)
	#

# initial network topology

def get_new_topo(new_rssi_level):
	f = open("topology.txt", "r")

	#wireless rssi topology injection & model establishment
	lines = f.readlines()
	#initialize schedule
	L_topo=list()
	L_topo.append(0)
	topo=lines[0].split()
	for topo_node in topo:
	    L_topo.append(int(topo_node))

	#print "L_topo: ", L_topo
	for channel_1 in [22, 23, 24, 25, 26]:
		channel=channel_1
		rssi_strength=new_rssi_level
		neignbour_strength=100
		sync_rssi_strength=100
		
		#for sender in range(1, 51):
		#	for receiver in range(1, 51):
		#		r.add(sender, receiver, float(neignbour_strength), channel_1)

		for i in range(1, len(lines)-1):
		    nodes_pre = lines[i].split()
		    nodes_post = lines[i+1].split()
		    for node1 in nodes_pre:
		        r.add(int(node1), 0, float(sync_rssi_strength), channel)
		        r.add(0, int(node1), float(sync_rssi_strength), channel)
		        #print "( "+str(node1)+", "+"0 )"+" rssi_level: "+str(float(sync_rssi_strength))
		        #schedule[i][j]=int(node1)
		        for node2 in nodes_post:
		            if i<len(lines)-2:
		                r.add(int(node1), int(node2), float(rssi_strength), channel)
		                r.add(int(node2), int(node1), float(rssi_strength), channel)
		            else:
		                r.add(int(node1), int(node2), float(neignbour_strength), channel)
		                r.add(int(node2), int(node1), float(neignbour_strength), channel)		            	
		                #print "( "+str(node1)+", "+str(node2)+" )"+" rssi_level: "+str(float(neignbour_strength))
		                #print "( "+str(node2)+", "+str(node1)+" )"+" rssi_level: "+str(float(neignbour_strength))

		for node in lines[len(lines)-1].split():
			r.add(int(node), 0, float(sync_rssi_strength), channel)
			r.add(0, int(node), float(sync_rssi_strength), channel)
			#print "( "+str(node)+", "+"0 )"+" rssi_level: "+str(float(sync_rssi_strength))
		i=0
		for line in lines:
		    if i!=0:
		        ns = line.split()
		        for n in ns:
		            for sibling in ns:
		                if int(n)!=int(sibling):
		                    r.add(int(n), int(sibling), float(neignbour_strength), channel)
		                    r.add(int(sibling), int(n), float(neignbour_strength), channel)
		                    #print "( "+str(n)+", "+str(sibling)+" )"+" rssi_level: "+str(float(-10))
		                    #print "( "+str(sibling)+", "+str(n)+" )"+" rssi_level: "+str(float(-10))
		    i=i+1
		for sensor in range(1, 51):
			r.add(sensor, 0, float(sync_rssi_strength), channel_1)
			r.add(0, sensor, float(sync_rssi_strength), channel_1)

	for node in range(0, len(topo)+1):
		m = t.getNode(node);
		for channel in [22, 23, 24, 25, 26]:
			if channel==22:
				noise = open("noise_chan22_110.txt", "r")
				lines = noise.readlines()
			elif channel==23:
				noise = open("noise_chan23_110.txt", "r")
				lines = noise.readlines()
			elif channel==24:
				noise = open("noise_chan24_110.txt", "r")
				lines = noise.readlines()
			elif channel==25:
				noise = open("noise_chan25_110.txt", "r")
				lines = noise.readlines()
			elif channel==26:
				noise = open("noise_chan26_110.txt", "r")
				lines = noise.readlines()
			for line in lines:
				strrr = line.strip()
				if (strrr != ""):
					val = int(strrr)
					m.addNoiseTraceReading(val, channel)
			m.createNoiseModel(channel);
		m.turnOn()
		m.bootAtTime(0)
		#print "Booting ", node, " at time ", str(0)

initialize_network()
#print "hello"
totalnode = 20
#print "totalnode: ", totalnode
CONNECTIVITY = 4
RSSI_DURATION = 20
THRESHOLD = 0.7
NUM_MEASUREMENTS=3
BACKLEVELS = 7
CONSEGOODNH=2
good_NH_counter=0
curr_NH_ratio=0.0
counter =0
#last_NH_ratio=0.0

seed=0

FRAMELENGTH=55
MAXNODES = 50

random.seed(fault_seed)

rssi_and_duration=[]
f=open(faultModel, "r")
lines = f.readlines()

for line in lines:
	tokens = line.split()
	duration = int(tokens[0])
	rssi = float(tokens[1])
	rssi_and_duration.append((rssi,duration))
print rssi_and_duration

#print rssi_and_duration

rssi_count=0
# read simu.cfg file

simu_fp = open("simu.cfg", "r")

WRITE_DIR=''

lines = simu_fp.readlines()

for line in lines:
	tokens = line.split()
	if tokens[0] == 'WRITE_DIR':
		WRITE_DIR = tokens[1].rstrip()

run_count = 1
sample_times = 0
consecutive_NH_counter=0
#flag bit for all 14 flows: 8 emergency flows + 2 regular flows + 4 actuation flows, 0 means not received.
measure_list=['0', '0', '0', '0', '0', '0', '0', '0', '0']

delaylist = np.empty(9)
delaylist.fill(float(totalnode)/float(100))

rcved=0

flag=0

pre_root_time=0
curr_root_time=0
while curr_root_time<=3000:
	t_run=time.clock()
	while (t.time() <= 100000000*run_count): # here the 100000000 represents 10ms
		t0 = time.clock()
		rcved = t.runNextEvent()
		if rcved[0] >= 1:
			curr_root_time = rcved[0]
	run_count = run_count + 1

	if (curr_root_time-pre_root_time) == 1:
		pre_root_time = curr_root_time
		sample_times +=1

	if sample_times == RSSI_DURATION:
		# change the current rssi value, random generate a integer value from range(-84, -62)
		(new_rssi, RSSI_DURATION) = rssi_and_duration[rssi_count]
		
		#print "new_rssi: ", new_rssi
		#print "new_duration: ", RSSI_DURATION
		get_new_topo(new_rssi)
		#RSSI_DURATION = random.randint(10, 200)
		rssi_count += 1
		control_input_file = open(WRITE_DIR+"_rssi_file.txt", "a")
		control_input_file.write(str(new_rssi))
		control_input_file.write('\t')
		control_input_file.write(str(RSSI_DURATION))
		control_input_file.write('\n')
		control_input_file.close()
		sample_times=0