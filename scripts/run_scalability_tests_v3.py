#!/usr/bin/env python3
import collections, subprocess, os, datetime, sys

# python3 run_scalability_tests.py | tee -a my_run_scalability_tests.log

'''
-----------   Experiments  -------------
116	"Standard_F16s",				"16",			"32768"
'''
# Machine	Num	Cores	Qtd
'''exp64=[
	# increasing size
	["Standard_F16s_v2",144,16,3],
	["Standard_F16s_v2",144,16,1],
	["Standard_F16s_v2",144,16,2],
	["Standard_F16s_v2",144,16,4],
	# 64 jobs
	["Standard_F64s_v2",146,64,1],
	["Standard_D64_v3",64,64,1],
	["Standard_D64s_v3",65,64,1],
	["Standard_E64_v3",108,64,1],
	["Standard_E32_v3",102,32,2],
	["Standard_E16_v3",98,16,4],
	["Standard_F32s_v2",145,32,2],
	["Standard_F16s_v2",144,16,4],
	["Standard_F16s",116,16,4],
	["Standard_D32_v3",55,32,2],
	["Standard_D16_v3",45,16,4],

	# 256 jobs
	["Standard_F64s_v2",146,64,4]
	["Standard_F16s_v2",144,16,16]
]'''

exp64=[
	["Standard_F16s_v2",144,16,1]

	# ["Standard_F16s_v2",144,16,16],
	# ["Standard_D16_v3",45,16,4],
	# ["Standard_F16s_v2",144,16,3],
	# ["Standard_E16_v3",98,16,4],
	# ["Standard_F16s",116,16,4],
	# ["Standard_D32_v3",55,32,2],
	# ["Standard_F16s_v2",144,16,4],
	# ["Standard_D64_v3",64,64,1],
	# ["Standard_F64s_v2",146,64,1],
	# ["Standard_D64s_v3",65,64,1],
	# ["Standard_F16s_v2",144,16,1],
	# ["Standard_F32s_v2",145,32,2],
	# ["Standard_E32_v3",102,32,2],
	# ["Standard_F16s_v2",144,16,2],
	# ["Standard_E64_v3",108,64,1],
	# ["Standard_F64s_v2",146,64,4]
]

# print ("Usage: %s [binary_dir]"% sys.argv[0])
if (len(sys.argv) < 2):
	bench_script =  './scripts/run_bench_dimensioned.sh'
	bench_script =  './scripts/run_bench_toy2dac.sh'
else:
	bench_script = sys.argv[1]
print('Going to execute the script: ', bench_script)
'''
experiments = [
	# [16],
	[12, 13],
	[16, 16],
	[12, 12, 12],
	[12, 12, 12, 13],
	[16, 16, 16, 16],
	[13, 13, 13, 14, 14, 14],
	[14, 14, 14, 14, 14, 15, 15],
	[15, 15, 15, 15, 15, 15, 15, 16],
	[15, 15, 15, 15, 16, 16, 16, 16],
	[16, 16, 16, 16, 16, 16, 16, 16],
	# [15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16],
	# [16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16],
	# [16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16],
[]]
'''

for exp in exp64:
	now = datetime.datetime.now()
	azure_machine_name,azure_machine_num = exp[0],exp[1]
	experiments=[[exp[2]]*exp[3]]
	print('\n\n\n\n\nRunning: azure_machine_name',azure_machine_name,'azure_machine_num',azure_machine_num, 'experiments', experiments, '\n\n\n\n')
	today_str = now.strftime("%d-%m-%Y")
	group_name = "g-%d-%s-%d-%d-%s"%(azure_machine_num, azure_machine_name.replace('_','-'), exp[2], exp[3], today_str)
	script_name = os.path.realpath('./scripts/run_mpi_benchmark_v10.sh')
	base_cmd = ' '.join(['bash', script_name, group_name])
	for experiment in experiments:
		if len(experiment)==0:
			break
		number_instances = len(experiment)
		number_process = sum(experiment)
		# Create more instances?
		# if (current_created_instances < number_instances):
		cmd = ' '.join([base_cmd, 'create', str(azure_machine_num), str(number_instances)])
		print('*************   *************   *************   *************   *************')
		print(cmd)
		print('*************   *************   *************   *************   *************')
		subprocess.run(cmd , shell = True) #, stdout = subprocess.PIPE, stderr = subprocess.PIPE)
			# current_created_instances = number_instances
		# Compose a hostfile patern and trigger experiments
		hostfile = collections.Counter(experiment)
		slots =''
		for slot in hostfile:
			key = slot
			value = hostfile[key]
			slots+= ' ' + str(value) + ' ' + str(key)
		cmd = ' '.join([base_cmd, 'execute', bench_script, str(number_process), slots])
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
