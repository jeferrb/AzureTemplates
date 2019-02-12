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
f = plt.figure(dpi=my_dpi)
# plt.ylim(0, 15000000)

font = {'family' : 'sans-serif',
		'size'   : 10}
		# 'weight' : 'bold',

rc('font', **font)

plt.clf()
# plt.ylim(bottom=0)
file='time_nas_mean.csv'

print('Handling %s' % file)
df = pd.read_csv(file)

npb_execution=1
npb_class='D'
npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']
for npb_bench in npb_benchs:
	# df2 = df.sort_values(by=['run2'],ascending=True).loc[
	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
				(df.loc[:,'bench'] == npb_bench) &
				(df.loc[:,'class'] == npb_class)]

	plt.title('%s.%s.%d'%(npb_bench,npb_class,64))
	# fig, (ax1, ax2) = plt.subplots()
	# df2.plot(kind='bar',x=0,y=5)
	plt.barh(df2['instance'], df2['run1'], align='center', color=colors)
	# this ---->>> plt.plot(df2['mean_general']/100, df2['instance'], 'D')
	# this ---->>> plt.show()
	# plt.scatter(df2['instance'], df2['run1'], color='r', marker='^')
	# plt.plot(df2['instance'], df2['run1'], 'o')
	plt.gca().invert_yaxis()
	plt.xlabel('Execution time (seconds)')
	f.savefig('charts_times/%s_%s_%s.png'%(npb_execution, npb_bench, npb_class), bbox_inches='tight', dpi=my_dpi)
	print('open charts_times/%s_%s_%s.png'%(npb_execution, npb_bench, npb_class))
	plt.clf()
