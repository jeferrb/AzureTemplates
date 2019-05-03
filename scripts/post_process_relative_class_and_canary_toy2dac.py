#!/bin/python3
# libraries
import numpy as np
import pandas as pd
import glob, os
import json, math

useconds=1000000


# import matplotlib.pyplot as plt
# from matplotlib import rc
# colors=['#e6194b','#3cb44b','#ffe119','#4363d8','#f58231','#911eb4','#46f0f0','#f032e6','#bcf60c','#fabebe','#008080',
# 		'#e6beff','#9a6324','#fffac8','#800000','#aaffc3','#808000','#ffd8b1','#000075','#808080','#ffffff']
# my_dpi=600
# f = plt.figure(dpi=my_dpi)
# plt.ylim(0, 15000000)
# font = {'family' : 'sans-serif',
# 		'size'   : 10}
# rc('font', **font)
# plt.clf()
# plt.ylim(bottom=0)

file='results_toy2dac_may02.csv'
# file='time_nas_mean_plus.csv'
print('Handling %s' % file)
df = pd.read_csv(file)











































# npb_execution=1
npb_classes=['A','B','C','D']
npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']
azure_setup = ['Standard_D16_v3', 'Standard_D32_v3', 'Standard_D64_v3', 'Standard_D64s_v3', 'Standard_E16_v3', 'Standard_E32_v3',
				'Standard_E64_v3', 'Standard_F16s', 'Standard_F16s_v2', 'Standard_F32s_v2', 'Standard_F64s_v2']


def from_csv_to_tex(csv_file_name, table_header, table_caption):
	table_label=csv_file_name[csv_file_name.find('/')+1:-4]
	f_csv = open(csv_file_name, "r")
	f_tex = open('%s.tex'%csv_file_name[:-4], "w")
	f_tex.write('\\begin{table}[ht]\n')
	f_tex.write('\\selectlanguage{english}\n')
	f_tex.write('\\centering\n')
	f_tex.write('\\caption{%s}\n'%table_caption)
	f_tex.write('\\label{tab:%s}\n'%table_label)
	f_tex.write('\\begin{tabular}{|*{%d}{c|}}\n'%(table_header.count('&')+1))
	f_tex.write('\\hline\n')
	f_tex.write(table_header)
	f_csv.readline() # discard first line
	line = f_csv.readline()
	while line:
		new_line='\\hline\n' + line.replace('Standard_', '').replace('_', '\\_').upper()
		f_tex.write(new_line[:len(new_line)-1] + ' \\\\\n')
		line = f_csv.readline()
	f_tex.write('\\hline\n')
	f_tex.write('\\end{tabular}\n')
	f_tex.write('\\end{table}\n')
	f_csv.close()
	f_tex.close()


first_samples_reference=[]

# file2='execution_1/Standard_D16_v3_instances_4_date_22-01-2019_result.csv'
for index, file2 in enumerate(sorted(glob.glob('execution_*/*.csv'))):
	print('Handling %s...' % file2)
	df3 = pd.read_csv(file2).T
	print('Processing experiments...')
	for x in range(0,32): # iterate over all lines
		# Get the index that split machine name
		k = df3.index[x].rfind('/')
		# Get the 'name of experiment'_native.log.csv
		experiment=df3.index[x][k+1:]
		# Remove '_native.log.csv'
		experiment=experiment[:len(experiment)-15]
		# print (experiment)
		# Remove date from setup (fist part of the string)
		setup_full=df3.index[x][:k-23]
		# 'k-7' Include the date but removes '_result'
		# setup_full=df3.index[x][:k-7]
		# Add the name of execution
		setup_full+='_'+file2[:file2.find('/')]
		# Handle the exception (one F16s has no version)
		inst_name_sz= (3 if setup_full.split('_', 3)[2] != 'instances' else 2)
		# Setup = just the name of machine
		setup = '_'.join(setup_full.split('_', inst_name_sz)[:inst_name_sz])
		print('%.2f per cent'%float(x/0.32))
		npb_execution=int(setup_full[-1])
		(npb_bench, npb_class, npb_jobs) = experiment.split('.',3)
		if (index==0): # if this is the reference machine, calculate the number of saples 
			first_samples_reference.append(math.floor((1000000*first_seconds)/df3.iloc[x,:].mean()))
		# for npb_bench in npb_benchs:
		# 	for npb_class in npb_classes:
		df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class) &
			(df.loc[:,'instance'] == setup) &
			(df.loc[:,'bench'] == npb_bench), 'mean_500']= (df3.iloc[x,:first_samples].mean())
		df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class) &
			(df.loc[:,'instance'] == setup) &
			(df.loc[:,'bench'] == npb_bench), 'mean_general']= (df3.iloc[x,:].mean())
		for y in range(1,11):
			df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'instance'] == setup) &
				(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(first_seconds*y)]= (df3.iloc[x,:(first_samples_reference[x]*y)].mean())
		samples = 0;
		sum_time_samples = 0;
		for seconds in range(1,60):
			while (sum_time_samples < (1000000 * seconds) and ( not math.isnan(df3.iloc[x,samples]) ) and len(df3.iloc[x,:]) > samples ):
				sum_time_samples+=df3.iloc[x,samples]
				samples+=1;
			# print("samples %d, sum_time_samples %d, len %d"%(samples, sum_time_samples, len(df3.iloc[x,:])))
			df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'instance'] == setup) &
				(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(seconds)]= df3.iloc[x,:samples].mean()

# Calculate how long time was spent to execute the first 500 samples 
# (df.iloc[543,12]*500)/1000000
df['time_mean_500_sec'] = df.apply(lambda row: row.mean_500*0.0005, axis=1)


# df2=pd.Series(index=azure_setup)
# df2=pd.DataFrame({'instance': azure_setup})

# npb_classes=['A','D']
# npb_benchs= ['bt',  'sp']
# azure_setup = ['Standard_D16_v3', 'Standard_F64s_v2']



# # BKP de ali de baixo..
# npb_execution=1
# for npb_bench in npb_benchs:
# 	print (npb_bench)
# 	for npb_class in npb_classes:
# 		print (npb_class)
# # Price based on NAS reported time
# 		for run in range(1,4):
# 			for setup in azure_setup:
# 				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
# 						(df.loc[:,'class'] == npb_class) &
# 						(df.loc[:,'instance'] == setup) &
# 						(df.loc[:,'bench'] == npb_bench), 'run%d'%run]
# 				current_price = df_price[(df_price.loc[:,'instance'] == setup)]
# 				df.loc[(df.loc[:,'execution'] == npb_execution) &
# 					(df.loc[:,'class'] == npb_class) &
# 					(df.loc[:,'instance'] == setup) &
# 					(df.loc[:,'bench'] == npb_bench), 'run_%s_price'%(run)] = float(
# 						(current_time * float(current_price.iloc[:,1]) * float(current_price.iloc[:,2]))/60)



#  Price calculation
df_price=pd.read_csv('instance_price.csv')
npb_execution=1
for npb_bench in npb_benchs:
	print (npb_bench)
	for npb_class in npb_classes:
		print (npb_class)
# Price based on NAS reported time
		for setup in azure_setup:
			current_price = df_price[(df_price.loc[:,'instance'] == setup)]
			current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_general']
			# Multiply time, price and number of instances, and divide by 60 (price in hour and time in minuts)
			df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'instance'] == setup) &
				(df.loc[:,'bench'] == npb_bench), 'mean_general_price'] = float(
						(current_time * float(current_price.iloc[:,1]) * float(current_price.iloc[:,2]))/60)
			# All 3 executions
			for run in range(1,4):
				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'run%d'%run]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'run_%s_price'%(run)] = float(
						(current_time * float(current_price.iloc[:,1]) * float(current_price.iloc[:,2]))/60)
			# Based on partial executions
			for y in range(1,11):
				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(first_seconds*y)]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(first_seconds*y)] = float(
						(current_time * float(current_price.iloc[:,1]) * float(current_price.iloc[:,2]))/60)
			# Based on partial executions 2
			for y in range(1,59):
				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(y)]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(y)] = float(
						(current_time * float(current_price.iloc[:,1]) * float(current_price.iloc[:,2]))/60)

# df = pd.read_csv('time_nas_mean_plus.csv')

# Normilize 
npb_execution=1
for npb_bench in npb_benchs:
	print (npb_bench)
	for npb_class in npb_classes:
		print (npb_class)
		min_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'bench'] == npb_bench), 'mean_general'].min()
		min_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'bench'] == npb_bench), 'mean_general_price'].min()
# Normilize general canary
		for setup in azure_setup:
			current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_general']
			current_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_general_price']
			df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'instance'] == setup) &
				(df.loc[:,'bench'] == npb_bench), 'mean_general_normalized'] = float(current_time/min_time)
			df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'instance'] == setup) &
				(df.loc[:,'bench'] == npb_bench), 'mean_general_normalized_price'] = float(current_price/min_price)
# Normilize fisrt X iterations
		for y in range(1,11):
			min_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(first_seconds*y)].min()
			min_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(first_seconds*y)].min()
			for setup in azure_setup:
				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(first_seconds*y)]
				current_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(first_seconds*y)]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_normalized'%(first_seconds*y)] = float(current_time/min_time)
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_normalized_price'%(first_seconds*y)] = float(current_price/min_price)
# Normilize fisrt Y seconds
		for y in range(1,59):
			min_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(y)].min()
			min_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(y)].min()
			for setup in azure_setup:
				current_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec'%(y)]
				current_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_price'%(y)]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_normalized'%(y)] = float(current_time/min_time)
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'mean_%s_sec_normalized_price'%(y)] = float(current_price/min_price)
# Normilize based on NAS reported time and price
		for run in range(1,4):
			min_time = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'run%d'%run].min()
			min_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'bench'] == npb_bench), 'run_%s_price'%(run)].min()
			for setup in azure_setup:
				current_value = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'run%d'%run]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'run_%s_normalized'%(run)] = float(current_value/min_time)
				current_price = df.loc[(df.loc[:,'execution'] == npb_execution) &
						(df.loc[:,'class'] == npb_class) &
						(df.loc[:,'instance'] == setup) &
						(df.loc[:,'bench'] == npb_bench), 'run_%s_price'%(run)]
				df.loc[(df.loc[:,'execution'] == npb_execution) &
					(df.loc[:,'class'] == npb_class) &
					(df.loc[:,'instance'] == setup) &
					(df.loc[:,'bench'] == npb_bench), 'run_%s_normalized_price'%(run)] = float(current_price/min_price)

df.to_csv('preprocessed.csv')
# exit()
# df = pd.read_csv('preprocessed.csv')

# build classifications
npb_execution=1
run=1
npb_class_D='D'
# table_header='Instance&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Class \\\\ D}&\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (2 min.)}&\\makecell{Mean \\\\ (5 min.)}&\\makecell{Mean \\\\ (10 min.)} \\\\\n'
table_header='Instance&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Class \\\\ D}&\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 seg.)}&\\makecell{Mean \\\\ (5 seg.)}&\\makecell{Mean \\\\ (10 seg.)} \\\\\n'
						# 'mean_60_sec_normalized', 'mean_120_sec_normalized', 'mean_300_sec_normalized', 'mean_600_sec_normalized']
for npb_bench in npb_benchs:
	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class_D) &
			(df.loc[:,'bench'] == npb_bench),['instance', 'run_%s_normalized'%(run), 'mean_general_normalized',
						'mean_1_sec_normalized', 'mean_2_sec_normalized', 'mean_5_sec_normalized', 'mean_10_sec_normalized']
								].rename(index=str, columns={'run_%s_normalized'%(run): 'run_%s_%s_classified'%(run, npb_class_D)})
	df22 = df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class_D) &
			(df.loc[:,'bench'] == npb_bench),['instance', 'run_%s_normalized_price'%(run), 'mean_general_normalized_price',
						'mean_1_sec_normalized_price', 'mean_2_sec_normalized_price', 'mean_5_sec_normalized_price', 'mean_10_sec_normalized_price']
								].rename(index=str, columns={'run_%s_normalized_price'%(run): 'run_%s_%s_classified_price'%(run, npb_class_D)})
	for npb_class in npb_classes[:3]:
		df4 = df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'bench'] == npb_bench),['run_%s_normalized'%(run)]
				].rename(index=str, columns={'run_%s_normalized'%(run): 'run_%s_%s_classified'%(run, npb_class)})
		df4.index=df2.index
		df2 = df2.join(df4)
		df44 = df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class) &
				(df.loc[:,'bench'] == npb_bench),['run_%s_normalized_price'%(run)]
				].rename(index=str, columns={'run_%s_normalized_price'%(run): 'run_%s_%s_classified_price'%(run, npb_class)})
		df44.index=df22.index
		df22 = df22.join(df4)
	df2.iloc[:,[0, 7, 8, 9, 1, 2, 3, 5, 6]].round(2).to_csv('tables/classifications_%s_time.csv'%npb_bench, sep='&', index=False)
	table_caption='%s benchmark execution time normalized on different comparison methods'%npb_bench.upper()
	from_csv_to_tex('tables/classifications_%s_time.csv'%npb_bench, table_header, table_caption)
	df22.iloc[:,[0, 7, 8, 9, 1, 2, 3, 5, 6]].round(2).to_csv('tables/classifications_%s_price.csv'%npb_bench, sep='&', index=False)
	table_caption='%s benchmark execution price normalized on different comparison methods'%npb_bench.upper()
	from_csv_to_tex('tables/classifications_%s_price.csv'%npb_bench, table_header, table_caption)



# # build classifications price based
# npb_execution=1
# run=1
# npb_class_D='D'
# my_dfs=[]
# table_header='Instance&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ D}&\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (2 min.)}&\\makecell{Mean \\\\ (5 min.)}&\\makecell{Mean \\\\ (10 min.)} \\\\\n'
# for npb_bench in npb_benchs:
# 	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
# 			(df.loc[:,'class'] == npb_class_D) &
# 			(df.loc[:,'bench'] == npb_bench),['instance', 'run_%s_normalized'%(run), 'mean_general_normalized',
# 						'mean_60_sec_normalized', 'mean_120_sec_normalized', 'mean_300_sec_normalized', 'mean_600_sec_normalized']
# 								].rename(index=str, columns={'run_%s_normalized'%(run): 'run_%s_%s_classified'%(run, npb_class_D)})
# 	for npb_class in npb_classes[:3]:
# 		df4 = df.loc[(df.loc[:,'execution'] == npb_execution) &
# 				(df.loc[:,'class'] == npb_class) &
# 				(df.loc[:,'bench'] == npb_bench),['run_%s_normalized'%(run)]
# 				].rename(index=str, columns={'run_%s_normalized'%(run): 'run_%s_%s_classified'%(run, npb_class)})
# 		df4.index=df2.index
# 		df2 = df2.join(df4)
# 	df2.iloc[:,[0, 7, 8, 9, 1, 2, 3, 4, 5, 6]].round(2).to_csv('tables/classifications_%s_price.csv'%npb_bench, sep='&', index=False)
# 	table_caption='%s benchmark normalized on different comparison methods'%npb_bench.upper()
# 	from_csv_to_tex('tables/classifications_%s_price.csv'%npb_bench, table_header, table_caption)
	

# print(df.columns)


# df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
# 			(df.loc[:,'class'] == npb_class_D) &
# 			(df.loc[:,'bench'] == npb_bench),['instance', 'run_%s_normalized'%(run), 'mean_general_normalized',
# 					'mean_60_sec_normalized', 'mean_120_sec_normalized', 'mean_300_sec_normalized', 'mean_600_sec_normalized']]


run=1
# Second Table
# Based on NAS reported time
df5=pd.DataFrame({'bench': npb_benchs})
for npb_bench in npb_benchs:
	# Classes as reference
	for index, npb_class in enumerate(npb_classes[:3]):
		idx_min_class = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class_D) &
				(df.loc[:,'bench'] == npb_bench),['run_%s_normalized'%(run)]].idxmin()) - (3 - index) # A - D = 3 (going back N indexes to get the normilized value corresponding the class selection)
		df5.loc[(df5.loc[:,'bench'] == npb_bench), 'selecting_%s'%npb_class] = float(df.iloc[idx_min_class].loc['run_%s_normalized'%(run)])
	# All means as reference
	idx_min_all_means = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class_D) &
			(df.loc[:,'bench'] == npb_bench),['mean_general_normalized']].idxmin())
	df5.loc[(df5.loc[:,'bench'] == npb_bench), 'selecting_all_means'] = float(df.iloc[idx_min_all_means].loc['mean_general_normalized'])
	for y in [1, 5, 10]:
		idx_min_all_means = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class_D) &
				(df.loc[:,'bench'] == npb_bench),['mean_%s_sec_normalized'%(y)]].idxmin())
		df5.loc[(df5.loc[:,'bench'] == npb_bench), 'selecting_%s_sec_means'%(y)] = float(df.iloc[idx_min_all_means].loc['mean_%s_sec_normalized'%(y)])

df5.round(2).to_csv('tables/classifications_methods_time.csv', sep='&', index=False)
# table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (5 min.)}\\\\\n'
table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 sec.)}&\\makecell{Mean \\\\ (5 sec.)}&\\makecell{Mean \\\\ (10 sec.)}\\\\\n'
table_caption='Time based overhead using different approaches'
from_csv_to_tex('tables/classifications_methods_time.csv', table_header, table_caption)

df5.iloc[:,[0, 1, 2, 3]].round(2).to_csv('tables/classifications_methods_time_a_b_c.csv', sep='&', index=False)
# table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (5 min.)}\\\\\n'
table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C}\\\\\n'
table_caption='Time based overhead using different approaches'
from_csv_to_tex('tables/classifications_methods_time_a_b_c.csv', table_header, table_caption)


# Thid Table
# considering relative execution price
df6=pd.DataFrame({'bench': npb_benchs})
for npb_bench in npb_benchs:
	# Classes as reference
	for index, npb_class in enumerate(npb_classes[:3]):
		idx_min_class = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class_D) &
				(df.loc[:,'bench'] == npb_bench),['run_%s_normalized_price'%(run)]].idxmin()) - (3 - index) # A - D = 3 (going back N indexes to get the normilized value corresponding the class selection)
		df6.loc[(df6.loc[:,'bench'] == npb_bench), 'selecting_%s'%npb_class] = float(df.iloc[idx_min_class].loc['run_%s_normalized_price'%(run)])
	# All means as reference
	idx_min_all_means = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'class'] == npb_class_D) &
			(df.loc[:,'bench'] == npb_bench),['mean_general_normalized_price']].idxmin())
	df6.loc[(df6.loc[:,'bench'] == npb_bench), 'selecting_all_means'] = float(df.iloc[idx_min_all_means].loc['mean_general_normalized_price'])
	for y in [1, 5, 10]:
		idx_min_all_means = int(df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'class'] == npb_class_D) &
				(df.loc[:,'bench'] == npb_bench),['mean_%s_sec_normalized_price'%(y)]].idxmin())
		df6.loc[(df6.loc[:,'bench'] == npb_bench), 'selecting_%s_sec_means'%(y)] = float(df.iloc[idx_min_all_means].loc['mean_%s_sec_normalized_price'%(y)])

df6.round(2).to_csv('tables/classifications_methods_price.csv', sep='&', index=False)
# table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (5 min.)}\\\\\n'
table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 sec.)}&\\makecell{Mean \\\\ (5 sec.)}&\\makecell{Mean \\\\ (10 sec.)}\\\\\n'
table_caption='Price based overhead using different approaches'
from_csv_to_tex('tables/classifications_methods_price.csv', table_header, table_caption)

df6.iloc[:,[0, 1, 2, 3]].round(2).to_csv('tables/classifications_methods_price_a_b_c.csv', sep='&', index=False)
# table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C} &\\makecell{Mean \\\\ (general)}&\\makecell{Mean \\\\ (1 min.)}&\\makecell{Mean \\\\ (5 min.)}\\\\\n'
table_header='Benchmark&\\makecell{Class \\\\ A} &\\makecell{Class \\\\ B} &\\makecell{Class \\\\ C}\\\\\n'
table_caption='Price based overhead using different approaches'
from_csv_to_tex('tables/classifications_methods_price_a_b_c.csv', table_header, table_caption)


# Save the result
df.to_csv('time_nas_mean_plus.csv')


exit()

from importlib import reload
import tmp
reload(tmp)