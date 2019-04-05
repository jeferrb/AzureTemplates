import re
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rc


# Collect time:
# (time ./KLP  source-graphs/LeNet-0604*.grf target-graphs/02*.tgt 0 initial-partitionings/lenet-604v-2p-49664-per-layers KLPcomm n 256) &> \
# ~/source_LeNet-0604_target-02p_0_initial-lenet-604v-2p-49664-per-layers_target-KLPcomm_verbose-n_lockedInput-256.output-1.log

# Generate CSV:
# grep "\*\*\*\*TIME\*\*\*" ~/source_*.log | awk '{print $2 ","$4 }' | less > simple.csv

file= "/home/jeferson/klp-jeferson/simple.csv"
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
# plt.show()

df_findBestSingleNodeMove.plot()
# plt.show()

df_computeCost.plot()
# plt.show()

df_findBestNodeExchange.plot()
# plt.show()

dfs = [df_findBestMove, df_findBestSingleNodeMove, df_computeCost, df_findBestNodeExchange]

for df_func in dfs:
	df_func['time'] = 0
	func=df_func.iloc[0,0]
	print(func)
	for i in range(len(df_func)-1,0, -1):
		df_func.iloc[i,2]=(df_func.iloc[i,1] - df_func.iloc[i-1,1])
	df_func.iloc[:,2].plot()
	plt.title(func)
	f.autofmt_xdate()
	f.savefig('%s.pdf'%(func), bbox_inches='tight')
	df_func.to_csv('%s.csv'%func)
		# print (i)

