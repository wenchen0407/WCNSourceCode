import sys

file_name1 = sys.argv[1]

file_name2 = sys.argv[2]

write_file_name=sys.argv[3]

print "file_name1", file_name1
print "file_name2", file_name2
print "write_file_name", write_file_name


res_file = open(file_name1, "r")
lines = res_file.readlines()

avg_delay=0.0
count=0
for line in lines:
	tokens = line.split('\n')
	avg_delay=avg_delay+float(tokens[0])
	count = count+1
avg_delay=avg_delay/float(count)

res_file.close()

print "avg_delay: ", avg_delay

res_file = open(file_name2, "r")
lines = res_file.readlines()

energy=0
count=0
avg_energy=0.0
for line in lines:
	tokens = line.split('\n')
	energy=energy+float(tokens[0])
	count = count+1
avg_energy=float(energy)/float(count)

res_file.close()


write_file = open(write_file_name, "a")
write_file.write(str(avg_delay))
write_file.write('\t')
write_file.write(str(avg_energy))
write_file.write('\n')

