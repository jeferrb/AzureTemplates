#!/bin/python3
# libraries
import pandas as pd
import math, sys

file='result_concat_results_mygroup2-01-03-2019.csv'
instance_name="Standard_F16s"
execution_number='1'

print('Handling %s' % file)
df = pd.read_csv(file)

npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']

df2 = pd.DataFrame()
for i_column, column in enumerate(df.columns):
	print('Processing %s'%column)
	samples = 0;
	sum_time_samples = 0;
	# column= 'results_mygroup2-01-03-2019/bt.D.100_native.log.csv'
	experiment=column.split('/')[1].split('.', 2)
	df2.loc[i_column,'execution'] = execution_number
	df2.loc[i_column,'class'] = experiment[1]
	df2.loc[i_column,'instance'] = instance_name
	df2.loc[i_column,'bench'] = experiment[0]
	df2.loc[i_column,'jobs'] = experiment[2].split('_',1)[0]
	for seconds in range(1,200):
		sys.stdout.write('.')
		sys.stdout.flush()
		while (sum_time_samples < (1000000 * seconds) and ( not math.isnan(df.iloc[samples,i_column]) ) and len(df.iloc[:,0]) > samples):
			sum_time_samples+=df.iloc[samples,i_column]
			samples+=1;
		df2.loc[i_column,'mean_%s_sec'%(seconds)]= sum_time_samples/float(samples) # df.iloc[:samples,i_column].mean()
	df2.loc[i_column,'mean_general_sec']= df.iloc[:,i_column].mean()
	sys.stdout.write('\n')
	sys.stdout.flush()

df2.to_csv('time_secs_stabilization_scalability.csv')
