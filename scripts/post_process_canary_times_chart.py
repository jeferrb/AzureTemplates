import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import matplotlib.patches as mpatches


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
file='time_nas_mean.csv'

print('Handling %s' % file)
df = pd.read_csv(file)

npb_execution=1
npb_class='D'
npb_benchs= ['bt', 'cg', 'ep', 'ft', 'is', 'lu', 'mg', 'sp']
labels=['Average (fisrt %s)' % fisrt_samples,'Average (all samples)', 'NPB reported time']

for npb_bench in npb_benchs:
	print ('Handling ', npb_bench)
	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'bench'] == npb_bench) &
			(df.loc[:,'class'] == npb_class)]
	plt.title('%s.%s.%d'%(npb_bench,npb_class,64))
	fig, ax1 = plt.subplots()
	ax1.plot(df2['instance'], df2['mean_%s' % fisrt_samples], 'rs', color='b', label=labels[1])
	ax1.plot(df2['instance'], df2['mean_general'], 'r^', color='g', label=labels[0])
	ax1.set_xlabel('Instance')
	fig.autofmt_xdate()
	# Make the y-axis label, ticks and tick labels match the line color.
	ax1.set_ylabel('Mean time (us)')
	ax1.tick_params('y')

	ax2 = ax1.twinx()
	ax2.plot(df2['instance'], df2['run2'], 'ro', color='r', label=labels[2])
	ax2.set_ylabel('NPB execution time (s)')
	ax2.tick_params('y')

	# Create custom legend
	leg1 = mpatches.Patch(color='b')
	leg2 = mpatches.Patch(color='g')
	leg3 = mpatches.Patch(color='r')
	# fig.legend(loc='center left', bbox_to_anchor=(1, 0.5))
	fig.legend(handles=[leg1, leg2, leg3], labels=labels, loc="center left", bbox_to_anchor=(1, 0.5))

	fig.tight_layout()
	fig.savefig('charts_times_compare/%s-%s-%d.png'%(npb_bench,npb_class,64), bbox_inches='tight', dpi=my_dpi)
	# plt.show()
	plt.clf()

print('open charts_times_compare')