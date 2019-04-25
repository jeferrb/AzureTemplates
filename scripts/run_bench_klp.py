#!/usr/bin/env python3

from threading import Thread, Semaphore, BoundedSemaphore
import subprocess, time, sys, os

# print ("This is the name of the script: ", sys.argv[0])
# print ("Number of arguments: ", len(sys.argv))
# print ("The arguments are: " , str(sys.argv))

if (len(sys.argv) < 4):
	print ("Usage: %s <num_repetitions> <output_dir> <total_virtual_cores>"% sys.argv[0])
	exit()

num_repetitions=int(sys.argv[1])
output_dir=sys.argv[2] #'~/'
numThreads=int(sys.argv[3]) # <--- used if not auto-detect the number of cores on the machine

print ("num_repetitions ", num_repetitions)
print ("output_dir ", output_dir)
print ('Executing %d process(es) simultaneously'%numThreads)

def executeCommand(cmd, i):
	global contThreads
	#print len(runs), str(i), cmd
	subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
	mutex.acquire()
	contThreads = contThreads -1
	mutex.release()

# try:
	# numThreads = int((subprocess.check_output("lscpu | grep socket", shell=True).strip()).decode().split(':')[-1])
# except Exception as e:
	# pass

# execution_example:	./KLP source-graphs/LeNet-0604vertices.grf target-graphs/2p-stm32f469xx.tgt 1 initial-partitionings/lenet-604v-2p-49664-per-layers KLPcomm n 256
executable = "./KLP "
experiments = [ [604,	2,	0,	"lenet-604v-2p-49664-per-layers", "KLPcomm",	'n',	256 ],			# 15 (aprox. time in seconds)
				[604,	2,	0,	"lenet-604v-2p-49664-irgreedy-locked", "KLPcomm",	'n',	256 ],		# 660
				[2343,	2,	0,	"lenet-2343v-2p-49664-per-layers", "KLPcomm",	'n',	1024 ],			# 7200
				[604,	4,	0,	"lenet-604v-4p-22528-irgreedy-locked", "KLPcomm",	'n',	256 ],		# 14400
				# [604,	2,	0,	"metis-604v-2p-ir-locked", "KLPiR",	'n',	256 ],						# 18000
				# [2343,	2,	0,	"lenet-2343v-2p-49664-greedy", "KLPcomm",	'n',	1024 ],				# 31500
				# [604,	11,	0,	"lenet-604v-11p-8192-greedy", "KLPcomm",	'n',	256 ],				# 39600
				# [604,	2,	0,	"lenet-604v-2p-49664-per-layers", "KLPcomm",	'n',	0 ],			# 36000
				# [604,	4,	0,	"lenet-604v-4p-22528-greedy", "KLPcomm",	'n',	0 ],				# 43200
				# [604,	2,	0,	"lenet-604v-2p-49664-irgreedy-locked", "KLPcomm",	'n',	0 ],		# 54000
				# [604,	2,	0,	"lenet-604v-2p-irgreedy-locked", "KLPiR",	'n',	256 ],				# 61200
				# [604,	4,	0,	"lenet-604v-4p-22528-irgreedy-locked", "KLPcomm",	'n',	256 ],		# 79200
				# [604,	11,	0,	"lenet-604v-11p-8192-greedy", "KLPcomm",	'n',	0 ],				# 93600
				# [604,	4,	0,	"metis-604v-4p-ir-locked", "KLPiR",	'n',	256 ],						# 133200
				# [604,	2,	0,	"lenet-604v-2p-49664-irgreedy", "KLPcomm",	'n',	0 ],				# 280800
				# [604,	11,	0,	"lenet-604v-11p-8192-irgreedy-locked", "KLPcomm",	'n',	256 ],		# 432000
				# [604,	4,	0,	"lenet-604v-4p-irgreedy", "KLPiR",	'n',	0 ],						# 540000
				# [604,	56,	0,	"lenet-604v-44p-2048-greedy", "KLPcomm",	'n',	256 ],				# 918000
				# [604,	63,	0,	"lenet-604v-44p-2048-greedy", "KLPcomm",	'n',	256 ],				# 1080000
				# [2343,	2,	0,	"lenet-2343v-2p-49664-per-layers", "KLPcomm",	'n',	1024 ],			# 10692000
				# [2343,	2,	0,	"lenet-2343v-2p-49664-per-layers", "KLPcomm",	'n',	0 ],			# 29548800
				# [2343,	4,	0,	"metis-2343v-4p-comm-free", "KLPcomm",	'n',	0 ],					# 33696000
				# [2343,	2,	0,	"lenet-2343v-2p-greedy", "KLPiR",	'n',	256 ],						# 45100800
				# [2343,	2,	0,	"lenet-2343v-2p-greedy", "KLPiR",	'n',	0 ],						# 59097600
				# [2343,	11,	0,	"metis-2343v-11p-comm-free", "KLPcomm",	'n',	0 ],					# 150336000
				[] ]


# build list of executions
runs = []
for exp in experiments:
	if (len(exp)==0):
		break
	for repetition in range(1,num_repetitions+1):
		output_file = '%s/source_LeNet-%04d_target-%02dp_%d_initial-%s_target-%s_verbose-%s_lockedInput-%d.output-%d.log'%(
			output_dir, exp[0], exp[1], exp[2], exp[3], exp[4], exp[5], exp[6], repetition)
		cmd = 'cd klp-jeferson; (time %s source-graphs/LeNet-%04d*.grf target-graphs/%02d*.tgt %d initial-partitionings/%s %s %s %d) 2>&1 | tee -a %s'%(
			executable, exp[0], exp[1], exp[2], exp[3], exp[4], exp[5], exp[6], output_file)
		print('execute_command: ', cmd)
		runs.append(cmd)

# print(runs)

# Retrieve the executable and the data
cmd="mkdir klp-jeferson; cd klp-jeferson; tar -xf "+os.path.expanduser("~/mymountpoint/klp-jeferson/klp-jeferson.tar")
subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)

abriuThread = False
i = 0
listaThreads = []
contThreads = 0
mutex = BoundedSemaphore(value=1)

while i < len(runs):
	abriuThread = False
	mutex.acquire()
	if contThreads < numThreads:
		print("Executing ", runs[i], i)
		t = Thread(target = executeCommand, args=(runs[i],i))
		t.start()
		listaThreads.append(t)
		contThreads = contThreads + 1
		abriuThread = True
		i = i + 1
	mutex.release()
	# so para o programa nao ficar em loop consumindo CPU quando estiver esperando as simulacoes
	if abriuThread == False:
		time.sleep(float(5.0))


# wait until any background job is complete
i = 0
while i < len(listaThreads):
	listaThreads[i].join()
	i = i + 1
