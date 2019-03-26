import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import matplotlib.patches as mpatches


colors=['#e6194b','#3cb44b','#ffe119','#4363d8','#f58231','#911eb4','#46f0f0','#f032e6','#bcf60c','#fabebe','#008080',
		'#e6beff','#9a6324','#fffac8','#800000','#aaffc3','#808000','#ffd8b1','#000075','#808080','#ffffff']
my_dpi=600
fisrt_samples=500
first_seconds=120
fig = plt.figure(dpi=my_dpi)
# plt.ylim(0, 15000000)

font = {'family' : 'sans-serif',
		'size'   : 10}
		# 'weight' : 'bold',

rc('font', **font)

plt.clf()
# plt.ylim(bottom=0)
file='preprocessed.csv'

print('Handling %s' % file)
df = pd.read_csv(file)

npb_execution=1
npb_class='D'
npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']
labels=['Average (fisrt %s)' % fisrt_samples,'Average (fisrt %s seconds)' % first_seconds,'Average (all samples)', 'NPB reported time']
azure_setup = ['Standard_D16_v3', 'Standard_D32_v3', 'Standard_D64_v3', 'Standard_D64s_v3', 'Standard_E16_v3', 'Standard_E32_v3',
				'Standard_E64_v3', 'Standard_F16s', 'Standard_F16s_v2', 'Standard_F32s_v2', 'Standard_F64s_v2']
colors=['#e6194b','#3cb44b','#ffe119','#4363d8','#f58231','#911eb4','#46f0f0','#f032e6','#bcf60c','#fabebe','#008080',
		'#e6beff','#9a6324','#fffac8','#800000','#aaffc3','#808000','#ffd8b1','#000075','#808080','#ffffff']



seclist=[]
for second in range (1,61):
	seclist.append(second)

for npb_bench in npb_benchs:
	print ('Handling ', npb_bench)
	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'bench'] == npb_bench) &
			(df.loc[:,'class'] == npb_class)].iloc[:,[23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43,
					44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
					65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 13]]
	for index, setup in enumerate (azure_setup):
		plt.plot(seclist, df2.iloc[index,:], label=setup, color=colors[index]) #'ro', 

	plt.title('%s.%s.%d'%(npb_bench,npb_class,64))
	plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))
	plt.xlabel('Sampling seconds')
	plt.ylabel('Paramount mean time')
	fig.autofmt_xdate()
	fig.tight_layout()
	fig.savefig('chart_stabilization/%s-%s-%d.png'%(npb_bench,npb_class,64), bbox_inches='tight', dpi=my_dpi)
	plt.clf()


print('open chart_stabilization')