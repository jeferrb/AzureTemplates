#!/bin/python3
# libraries
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
import glob, os

f = plt.figure()

for file in glob.glob('Standard_D32_v3*.csv'):
	print('Handling %s' % file)
	df = pd.read_csv(file).T
	# for x in range(0,31):
	for x in range(3,31,4):
		plt.clf()
		k = df.index[x].rfind('/')
		experiment=df.index[x][k+1:]
		experiment=experiment[:len(experiment)-15]
		# setup=df.index[x][:k-23]
		setup=df.index[x][:k]
		# TODO: descrebe the name of setup at title
		print (experiment)
		plt.ylim(0, 9000000)
		# plt.xlim(0,10)
		# plt.axis([0, 10, 0, 20])
		plt.title(experiment)
		plt.plot(df.iloc[x,:500])
		# plt.show()
		# f.savefig('charts/%s_%s.pdf'%(setup ,experiment), bbox_inches='tight')
		f.savefig('new_chart/%s_%s.png'%(setup ,experiment), bbox_inches='tight', dpi=300)


# #!/bin/python3
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


smooth_size=1000
my_color=0
means=[]
# colors=['b','g','r','c','m','y','k']
colors=['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff']
# for file in glob.glob('Standard_D32_v3*.csv'):
for file in glob.glob('Standard_D16_v3*.csv'):
# for file in glob.glob('*.csv'):
	print('Handling %s' % file)
	df = pd.read_csv(file).T
	# for x in range(0,31):
	# for x in range(3,31,4):
	x=3
	if 1:
		k = df.index[x].rfind('/')
		experiment=df.index[x][k+1:]
		experiment=experiment[:len(experiment)-15]
		# setup=df.index[x][:k-23]
		setup=df.index[x][:k-7]
		print (experiment)
		plt.title(experiment)
		# df2 = pd.DataFrame(data=None, index=df.index)
		df2 = []
		mean=(setup, experiment, df.iloc[x,:].mean())
		means.append(mean)
		for y in range(0,len(df.iloc[x,:]),smooth_size):
			# if (y < len(df.iloc[x,:]):
			df2.append(df.iloc[x,y:y+smooth_size].mean())
		plt.plot(df2, color=colors[my_color], label=setup)
		plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))
		# plt.show()
		# f.savefig('charts/%s_%s.pdf'%(setup ,experiment), bbox_inches='tight')
	
	my_color+=1
	if my_color > len(colors):
		my_color=0

plt.ylim(bottom=0)
f.savefig('new_chart/%s.png'%(experiment), bbox_inches='tight', dpi=300)
# plt.clf()
with open('new_chart/%s.data.json'%(experiment), 'w') as outfile:
    json.dump(means, outfile)
