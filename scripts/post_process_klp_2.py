import re
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rc
from pylab import figure

'''
# Collect time:
./run_all_klp_1.sh # maybe

# Generate CSV:
for result in results_mygroup-klp-2*-04-2019-machine-*/result/source_*.log; do
	echo $result
	echo ${result} > ${result}.csv
	tail -n2 ${result} | head -n1 | awk '{print $1 "\n" $2 "\n" $3}' | sed 's/[a-z]//g' >> ${result}.csv
	grep TIME $result | awk '{print $2}' >> ${result}.csv
done
paste -d, results_mygroup-klp-26-04-2019-machine-*/result/*.csv > klp_results.csv
'''


'''
# 10     "Standard_A2",            "2",       "3584" x
100    "Standard_E2_v3",         "2",       "16384"
101    "Standard_E2s_v3",        "2",       "16384"
11     "Standard_A2_v2",         "2",       "4096"
118    "Standard_F2",            "2",       "4096"
119    "Standard_F2s",           "2",       "4096"
17     "Standard_A5",            "2",       "14336"
# 2      "Basic_A2",               "2",       "3584" x
32     "Standard_D11",           "2",       "14336"
33     "Standard_D11_v2",        "2",       "14336"
47     "Standard_D2",            "2",       "7168"
48     "Standard_D2_v2",         "2",       "7168"
50     "Standard_D2_v3",         "2",       "8192"
'''


machines = {
10:     "Standard_A2",
100:    "Standard_E2_v3",
101:    "Standard_E2s_v3",
11:     "Standard_A2_v2",
118:    "Standard_F2",
119:    "Standard_F2s",
17:     "Standard_A5",
2:      "Basic_A2",
32:     "Standard_D11",
33:     "Standard_D11_v2",
47:     "Standard_D2",
48:     "Standard_D2_v2",
50:     "Standard_D2_v3"
}


experiments= [
'source_LeNet-0604_target-02p_0_initial-lenet-604v-2p-49664-irgreedy-locked_target-KLPcomm_verbose-n_lockedInput-256.output-1.log',
'source_LeNet-0604_target-02p_0_initial-lenet-604v-2p-49664-per-layers_target-KLPcomm_verbose-n_lockedInput-256.output-1.log',
'source_LeNet-0604_target-04p_0_initial-lenet-604v-4p-22528-irgreedy-locked_target-KLPcomm_verbose-n_lockedInput-256.output-1.log',
'source_LeNet-2343_target-02p_0_initial-lenet-2343v-2p-49664-per-layers_target-KLPcomm_verbose-n_lockedInput-1024.output-1.log'
]

# file= "/home/jeferson/klp-jeferson/simple.csv"
file= "klp_results.csv"
# creteria= "TIME"

df = pd.read_csv(file)
# df.columns=['func', 'timestamp']

df_time=df.drop(df.index[3:])

df=df.drop(df.index[0:4]).astype(float)

for experiment in experiments:
	df_expermient = df.loc[:, df.columns.str.contains(experiment)]
	new_names={}
	for col in df_expermient.columns:
		machine_name = machines[int(col.split("machine-")[1].split('/',1)[0])]
		new_names.update({col:machine_name})
	# df.rename(columns=lambda col: machines[int(col.split("machine-")[1].split('/',1)[0])], inplace=True).columns
	df_expermient.rename(columns=new_names, inplace=True)
	exp_name=col.split("result/")[1][:-4]
	# normal
	plt.title(exp_name.split(".")[0])
	plt.plot(df_expermient)
	plt.savefig('%s.pdf'%(exp_name))
	plt.clf()
	# Smooth
	wind=int(len(df_expermient)/100)
	rolling = df_expermient.rolling(window=wind)
	rolling_mean = rolling.mean()
	rolling_mean.plot()
	plt.savefig('%s_mean.pdf'%(exp_name))
	plt.clf()
	# Time
	fig = figure()
	df_expermient = df_time.loc[:, df_time.columns.str.contains(experiment)]
	df_expermient.rename(columns=new_names, inplace=True)
	plt.title(exp_name.split(".")[0])
	df_expermient.iloc[0].astype(float).plot.bar()
	plt.tick_params('y')
	fig.autofmt_xdate()
	plt.savefig('%s_time.pdf'%(exp_name))
	plt.clf()
