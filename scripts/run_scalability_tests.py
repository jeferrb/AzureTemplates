#!/usr/bin/env python3

import collections, subprocess, os, datetime


# python3 run_scalability_tests.py | tee -a my_run_scalability_tests.log

'''
-----------   Experiments  -------------
116	"Standard_F16s",				"16",			"32768"

'''

experiments = [
	# [16],
	# [12, 13],
	# [16, 16],
	# [12, 12, 12],
	# [12, 12, 12, 13],
	# [16, 16, 16, 16],
	# [13, 13, 13, 14, 14, 14],
	# [14, 14, 14, 14, 14, 15, 15],
	# [15, 15, 15, 15, 15, 15, 15, 16],
	# [15, 15, 15, 15, 16, 16, 16, 16],
	# [16, 16, 16, 16, 16, 16, 16, 16],
	# [15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16],
	# [16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16],
	[16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16]
]

now = datetime.datetime.now()
group_name = now.strftime("mygroup-%d-%m-%Y")
script_name = os.path.realpath('./run_mpi_benchmark_v9.sh')
base_cmd = 'bash ' + script_name + ' ' + group_name
azure_machines = 116 # Standard_F16s
current_created_instances = 0
for experiment in experiments:
	number_instances = len(experiment)
	number_process = sum(experiment)
	# Create more instances?
	if (current_created_instances < number_instances):
		cmd = base_cmd + ' create ' + str(azure_machines) + ' ' + str(number_instances - current_created_instances)
		print('*************   *************   *************   *************   *************')
		print(cmd)
		print('*************   *************   *************   *************   *************')
		subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
		current_created_instances = number_instances
	# Compose a hostfile patern and trigger experiments
	hostfile = collections.Counter(experiment)
	slots =''
	for slot in hostfile:
		key = slot
		value = hostfile[key]
		slots+= ' ' + str(value) + ' ' + str(key)
	cmd = base_cmd + ' execute ' + str(number_process) + ' ' + slots
	print('*************   *************   *************   *************   *************')
	print(cmd)
	print('*************   *************   *************   *************   *************')
	subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)

# Retrieve results ans destroy cloud infrastructure
cmd = base_cmd + ' destroy'
print('*************   *************   *************   *************   *************')
print(cmd)
print('*************   *************   *************   *************   *************')
subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)

# azure_machines =98
# number_instances =4
# MOUNTPOINT =$HOME/mymountpoint
# RESULTS_DIRECTORY ="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${azure_machines}_instances_${number_instances}_date_$(date +%d-%m-%Y)_result"
# mkdir -p ${RESULTS_DIRECTORY}
# ./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg == ${azure_machines} ${number_instances} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &