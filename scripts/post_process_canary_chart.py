#!/bin/python3
# libraries
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import glob, os
import json

# df = pd.read_csv('Standard_D16_v3_instances_4_date_22-01-2019_result.csv').T

f = plt.figure(dpi=600)
# plt.ylim(0, 15000000)

font = {'family' : 'sans-serif',
		'size'   : 10}
		# 'weight' : 'bold',

rc('font', **font)

# function getPosition(string, subString, index) {
#    return }
# string.split(subString, index).join(subString).length;

# params=[[100,'execution_*', '*.csv']]
params=[
		[0,'execution_1', '*.csv'],
		[0,'execution_*', 'Standard_F16s_v2*.csv'],
		[0,'execution_*', 'Standard_D32_v3*.csv'],
		[100,'execution_1', '*.csv'],
		[100,'execution_*', '*.csv'],
		[100,'execution_*', 'Standard_D16_v3*.csv'],
		[100,'execution_*', 'Standard_F16s_v2*.csv'],
		[100,'execution_3', '*.csv'],
		[100,'execution_*', 'Standard_D32_v3*.csv']]

my_dpi=300
output_dir = ('charts_fluctuation/chart_compare_fluctuation_%s%s' % (machines_simplified, 
	('chart_points_%s' % chart_points) if chart_points else ('fisrt_%s_samples'% fisrt_samples)))
# colors=['b','g','r','c','m','y','k']
colors=['#e6194b','#3cb44b','#ffe119','#4363d8','#f58231','#911eb4','#46f0f0','#f032e6','#bcf60c','#fabebe','#008080',
		'#e6beff','#9a6324','#fffac8','#800000','#aaffc3','#808000','#ffd8b1','#000075','#808080','#ffffff']

while len(params)!=0:

	(chart_points,executions, instance)=params.pop() # 0 if fisrt_samples
	fisrt_samples=500
	machines=executions+ '/' + instance
	means=[]
	df3=[]
	machines_simplified= ('executions_all' if (executions.find('*')!=-1) else executions) + '_' + 
			machines[0 if (machines.find('/') == -1) else machines.find('/')+1:machines.rfind('*')]
	plt.clf()
	# plt.ylim(bottom=0)
	my_color=0

	if not os.path.exists(output_dir):
		os.makedirs(output_dir)


	# Iterate (4) over benchs (8 banchs * 4 classes = 31) class D (3)
 	for x in range(3,31,4):
		for index, file in enumerate(sorted(glob.glob(machines))):
			print('Handling %s' % file)
			df = pd.read_csv(file).T
			# Get the index that split machine name
			k = df.index[x].rfind('/')
			# Get the 'name of experiment'_native.log.csv
			experiment=df.index[x][k+1:]
			# Remove '_native.log.csv'
			experiment=experiment[:len(experiment)-15]
			# Remove date from setup (fist part of the string)
			setup_full=df.index[x][:k-23]
			# 'k-7' Include the date but removes '_result'
			# setup_full=df.index[x][:k-7]
			# Add the name of execution
			setup_full+='_'+file[:file.find('/')]
			# Handle the exception (one F16s has no version)
			inst_name_sz= (3 if setup_full.split('_', 3)[2] != 'instances' else 2)
			# Setup = just the name of machine
			setup='_'.join(setup_full.split('_', inst_name_sz)[:inst_name_sz])
			# If it is a mult-experiment, add this information on label
			setup+=((' '+file[:file.find('/')]) if (executions.find('*')!=-1) else '')
			print (experiment)
			# df2 = pd.DataFrame(data=None, index=df.index)
			df2 = []
			mean=(setup_full, experiment, df.iloc[x,:].mean(), colors[index])
			means.append(mean)
			valid_numbers=int(len(df.iloc[x])-df.iloc[x].isna().sum())
			plt.title(experiment)
			if chart_points:
				smooth_size=int((valid_numbers/3)/chart_points)
				for y in range(0,int(valid_numbers/3),smooth_size):
					# if (y < len(df.iloc[x,:]):
					df2.append(df.iloc[x,y:y+smooth_size].mean())
				plt.plot(df2, color=colors[index], label=setup)
				df2.append(mean)
				df3.append(df2)
			else:
				plt.plot(df.iloc[x,:fisrt_samples], color=colors[index], 
					label='%s %.2f %.2f'%(setup,(df.iloc[x,:fisrt_samples].mean()/1000.0), (df.iloc[x,:].mean()/1000.0)))
				df2.append(df.iloc[x,:fisrt_samples].mean()/1000.0)
				df2.append(df.iloc[x,:].mean()/1000.0)
				df2.append(mean)
				df3.append(df2)
			plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))
			# my_color+=1
			# if my_color > len(colors):
			# 	my_color=0
		f.savefig('%s/%s.png'%(output_dir, experiment), bbox_inches='tight', dpi=my_dpi)
		plt.clf()
		if chart_points:
			with open('%s/%s.data.json'%(output_dir, experiment), 'w') as outfile:
				json.dump(df3, outfile)

	print("open %s" % output_dir)

quit()


for file in glob.glob('%s/*.data.json'%(output_dir)):
	with open(file) as infile:
		df3 = json.load(infile)
	for exp in range(0,len(df3)):
		(setup, experiment, mean, my_color)=df3[exp].pop()
		plt.title(experiment)
		plt.plot(df3[exp], color=my_color, label=setup)
		plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))
	f.savefig('%s/%s.png'%(output_dir, experiment), bbox_inches='tight', dpi=my_dpi)
	plt.clf()



