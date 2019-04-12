import re
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rc

'''
# Collect time:
(time ./KLP  source-graphs/LeNet-0604*.grf target-graphs/02*.tgt 0 initial-partitionings/lenet-604v-2p-49664-per-layers KLPcomm n 256) &> \
~/source_LeNet-0604_target-02p_0_initial-lenet-604v-2p-49664-per-layers_target-KLPcomm_verbose-n_lockedInput-256.output-1.log

# Generate CSV:
grep "\*\*\*\*TIME\*\*\*" ~/source_*.log | awk '{print $2 ","$4 }' | less > simple.csv
'''

# file= "/home/jeferson/klp-jeferson/simple.csv"
file= "simple.csv"
creteria= "TIME"

#       1 run
#     673 findBestMove
#  232340 findBestSingleNodeMove
#  416242 computeCost
# 1467250 findBestNodeExchange

df = pd.read_csv(file)
df.columns=['func', 'timestamp']

df_findBestMove = df.loc[(df.loc[:, 'func'] == 'findBestMove')]
df_findBestSingleNodeMove =  df.loc[(df.loc[:, 'func'] == 'findBestSingleNodeMove')]
df_computeCost =  df.loc[(df.loc[:, 'func'] == 'computeCost')]
df_findBestNodeExchange =  df.loc[(df.loc[:, 'func'] == 'findBestNodeExchange')]

df_findBestMove.plot()
df_findBestSingleNodeMove.plot()
df_computeCost.plot()
df_findBestNodeExchange.plot()

dfs = [df_findBestMove, df_findBestSingleNodeMove, df_computeCost, df_findBestNodeExchange]

for df_func in dfs:
# df_func['time'] = 0
	func=df_func.iloc[0,0]
	print(func)
	tmp_array=[]
	for i in range(0, len(df_func)-1, 2):
		tmp_array.append(df_func.iloc[i+1,1] - df_func.iloc[i,1])
	df2 = pd.DataFrame(tmp_array, columns=['timestamp'])
	step=(int(len(df2)/1000)) if (len(df2)>1000) else 1
	print('lendf', len(df2))
	tmp_array2 = []
	for i in range(0, len(df2), step):
		tmp_array2.append(df2.iloc[i:(i+step),0].mean())
	plt.title(func)
	plt.plot(tmp_array2)
	# plt.show()
	plt.savefig('%s.pdf'%(func))
	plt.clf()
	# plt.show()
	# v = df_func.groupby(df_func.index // 2).timestamp.sum()
	# v.index = df_func.func[::2]
	# df_func = v.reset_index()
	# df_func.iloc[:,1].plot()
	# plt.autofmt_xdate()
	# df_func.to_csv('%s.csv'%func)
		# print (i)

