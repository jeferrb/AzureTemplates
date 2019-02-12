#!/bin/python3
# libraries
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import glob, os
import json

colors=['#e6194b','#3cb44b','#ffe119','#4363d8','#f58231','#911eb4','#46f0f0','#f032e6','#bcf60c','#fabebe','#008080',
		'#e6beff','#9a6324','#fffac8','#800000','#aaffc3','#808000','#ffd8b1','#000075','#808080','#ffffff']
my_dpi=600
fisrt_samples=500
f = plt.figure(dpi=my_dpi)
# plt.ylim(0, 15000000)

font = {'family' : 'sans-serif',
		'size'   : 10}
		# 'weight' : 'bold',

rc('font', **font)

plt.clf()
# plt.ylim(bottom=0)
file='time_nas.csv'

print('Handling %s' % file)
df = pd.read_csv(file)

# npb_execution=1
npb_classes=['A','B','C','D']
npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']
df['mean_500'] = float('nan')
df['mean_general'] = float('nan')


# for npb_bench in npb_benchs:
# 	df.loc[(df.loc[:,'execution'] == npb_execution) &
# 			(df.loc[:,'bench'] == npb_bench) &
# 			(df.loc[:,'class'] == npb_class)] = float(4)
# 	plt.title('%s.%s.%d'%(npb_bench,npb_class,64))
# 	# df2.plot(kind='bar',x=0,y=5)
# 	plt.barh(df2['instance'], df2['run1'], align='center', color=colors)
# 	plt.gca().invert_yaxis()
# 	plt.xlabel('Execution time (seconds)')
# 	f.savefig('charts_times/%s_%s_%s.png'%(npb_execution, npb_bench, npb_class), bbox_inches='tight', dpi=my_dpi)
# 	print('open charts_times/%s_%s_%s.png'%(npb_execution, npb_bench, npb_class))
# 	plt.clf()

# file2='execution_1/Standard_D16_v3_instances_4_date_22-01-2019_result.csv'
for index, file2 in enumerate(sorted(glob.glob('execution_*/*.csv'))):
	print('Handling %s...' % file2)
	df3 = pd.read_csv(file2).T
	print('Processing experiment:')
	for x in range(0,31): # iterate over all lines
		# Get the index that split machine name
		k = df3.index[x].rfind('/')
		# Get the 'name of experiment'_native.log.csv
		experiment=df3.index[x][k+1:]
		# Remove '_native.log.csv'
		experiment=experiment[:len(experiment)-15]
		print (experiment)
		# Remove date from setup (fist part of the string)
		setup_full=df3.index[x][:k-23]
		# 'k-7' Include the date but removes '_result'
		# setup_full=df3.index[x][:k-7]
		# Add the name of execution
		setup_full+='_'+file2[:file2.find('/')]
		# Handle the exception (one F16s has no version)
		inst_name_sz= (3 if setup_full.split('_', 3)[2] != 'instances' else 2)
		# Setup = just the name of machine
		setup='_'.join(setup_full.split('_', inst_name_sz)[:inst_name_sz])
		npb_execution=int(setup_full[-1])
		for npb_bench in npb_benchs:
			for npb_class in npb_classes:
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_500']= (df3.iloc[x,:fisrt_samples].mean())
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_general']= (df3.iloc[x,:].mean())

df.to_csv('time_nas_mean.csv')
