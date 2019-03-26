import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import matplotlib.patches as mpatches


colors=['b', 'c', 'g']
my_dpi=600
fisrt_samples=500
first_seconds=1
f = plt.figure(dpi=my_dpi)
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
labels=['Average (fisrt %s sec.)' % first_seconds,'Average (all samples)', 'NPB reported time']

width = 0.8

for npb_bench in npb_benchs:
	print ('Handling ', npb_bench)
	df2 = df.loc[(df.loc[:,'execution'] == npb_execution) &
			(df.loc[:,'bench'] == npb_bench) &
			(df.loc[:,'class'] == npb_class)]
	plt.title('%s.%s.%d'%(npb_bench,npb_class,64))
	fig, ax1 = plt.subplots()

	vals = [df2['mean_general'], df2['mean_%s_sec'%first_seconds], df2['run2']]
	n = len(vals)
	_X = np.arange(len(df2['instance']))
	for i in range(n -1 ):
		ax1.bar(_X - width/2. + i/float(n)*width, vals[i], 
				width=width/float(n), align="edge", color=colors[i])

	ax1.set_xlabel('Instance')
	fig.autofmt_xdate()
	# Make the y-axis label, ticks and tick labels match the line color.
	ax1.set_ylabel('Mean time (us)')
	ax1.tick_params('y')

	ax2 = ax1.twinx()
	i=i+1
	ax2.bar(_X - width/2. + i/float(n)*width, vals[i], 
				width=width/float(n), align="edge", color=colors[i])
	# ax2.plot(df2['instance'], , 'ro', color='r', label=labels[2])
	ax2.set_ylabel('NPB execution time (s)')
	ax2.tick_params('y')

	plt.xticks(_X, df2['instance'])

	# Create custom legend
	leg1 = mpatches.Patch(color=colors[0])
	leg2 = mpatches.Patch(color=colors[1])
	leg3 = mpatches.Patch(color=colors[2])
	# fig.legend(loc='center left', bbox_to_anchor=(1, 0.5))
	fig.legend(handles=[leg1, leg2, leg3], labels=labels, loc="center left", bbox_to_anchor=(1, 0.5))
	# fig.legend(loc='center left', bbox_to_anchor=(1, 0.5))

	fig.tight_layout()
	fig.savefig('charts_times_compare/%s-%s-%d.png'%(npb_bench,npb_class,64), bbox_inches='tight', dpi=my_dpi)
	# plt.show()
	plt.clf()

print('open charts_times_compare')