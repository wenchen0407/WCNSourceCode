import sys

read_file=sys.argv[1]
write_file=sys.argv[2]

f=open(read_file, "r")
lines=f.readlines()

rms=0.0
sum_res=0.0
max_res=0.0
counter=0
for line in lines:
	value=float(line)
	rms += pow(value, 2)
	sum_res += value
	if max_res < value:
		max_res = value
	counter += 1
rms=rms/float(counter)
rms=pow(rms, 0.5)

f=open(write_file, "a")

f.write(str(rms))
f.write('\t')
f.write(str(sum_res))
f.write('\t')
f.write(str(max_res))
f.write('\n')

f.close()



