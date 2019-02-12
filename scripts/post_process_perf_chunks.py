# libraries
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd
 
# Data
r = [0,1,2,3,4]
raw_data = {'greenBars': [20, 1.5, 7, 10, 5], 'orangeBars': [5, 15, 5, 10, 15],'blueBars': [2, 15, 18, 5, 10]}
df = pd.DataFrame(raw_data)
df_sun = pd.read_csv('/Users/jeferson/Desktop/all_benchs.D.64.sun_minutes.csv')
df1min = pd.read_csv('/Users/jeferson/Desktop/all_benchs.D.64.1_minute.csv')


# Organize chunks based in 5 min execution
df_sun_ordered=pd.DataFrame().reindex_like(df_sun)
df1min_ordered=pd.DataFrame().reindex_like(df1min)

for index_col in range(0, df_sun.iloc[1,:].size,10):
	for index_row in range(0,df_sun.iloc[:,1].size):
		for i in range(0,9,2):
			try:
				# value = df_sun.iloc[index_row,index_col+9]
				# if (value != '[unknown]'):
				selected_row=df_sun[df_sun.iloc[:,index_col+i].str.contains(df_sun.iloc[index_row,index_col+8], regex=False, na=False)]
				df_sun_ordered.iloc[index_row, index_col+i]=selected_row.iloc[0,index_col+i]
				df_sun_ordered.iloc[index_row, index_col+i+1]=selected_row.iloc[0,index_col+i+1]
			except Exception as e:
				pass

for index_col in range(0, df1min.iloc[1,:].size,10):
	for index_row in range(0,df1min.iloc[:,1].size):
		for i in range(0,9,2):
			try:
				# value = df1min.iloc[index_row,index_col+9]
				# if (value != '[unknown]'):
				selected_row=df1min[df1min.iloc[:,index_col+i].str.contains(df1min.iloc[index_row,index_col+8], regex=False, na=False)]
				df1min_ordered.iloc[index_row, index_col+i]=selected_row.iloc[0,index_col+i]
				df1min_ordered.iloc[index_row, index_col+i+1]=selected_row.iloc[0,index_col+i+1]
			except Exception as e:
				pass

df_sun_ordered.to_csv('/Users/jeferson/Desktop/df_sun_ordered.csv', sep=',')
df1min_ordered.to_csv('/Users/jeferson/Desktop/df1min_ordered.csv', sep=',')
		

# df_sun = df_sun.drop(df_sun.columns[my_list], axis=1).head(max_rows).transpose()
# df_sun = df_sun.drop(0, axis=1)
# df_sun.to_csv('/Users/jeferson/Desktop/concat_perf_new_2_without-unknown_1.csv', sep=',')


# From raw value to percentage
# totals = [i+j+k for i,j,k in zip(df['greenBars'], df['orangeBars'], df['blueBars'])]
# greenBars = [i / j * 100 for i,j in zip(df['greenBars'], totals)]
# orangeBars = [i / j * 100 for i,j in zip(df['orangeBars'], totals)]
# blueBars = [i / j * 100 for i,j in zip(df['blueBars'], totals)]

for x in range(0,10):
	pass
 
# plot
barWidth = 0.85
names = ('min 1','min 2','min 3','min 4','min 5')

# Flush the graph
plt.gcf().clear()

for i in 

# Create green Bars func1
plt.bar(r, greenBars,                                                    color='#b5ffb9', edgecolor='white', width=barWidth, label="group A")
# Create orange Bars func2
plt.bar(r, orangeBars, bottom=greenBars,                                 color='#f9bc86', edgecolor='white', width=barWidth, label="group B")
# Create blue Bars func3
plt.bar(r, blueBars, bottom=[i+j for i,j in zip(greenBars, orangeBars)], color='#a3acff', edgecolor='white', width=barWidth, label="group C")
 
# Custom x axis
plt.xticks(r, names)
plt.xlabel("group")

# Add a legend
plt.legend(loc='upper left', bbox_to_anchor=(1,1), ncol=1)


plt.savefig('/Users/jeferson/Desktop/fig1.png')


# Show graphic
# plt.show()











 
# From raw value to percentage
totals = [i+j+k for i,j,k in zip(df['greenBars'], df['orangeBars'], df['blueBars'])]
greenBars = [i / j * 100 for i,j in zip(df['greenBars'], totals)]
orangeBars = [i / j * 100 for i,j in zip(df['orangeBars'], totals)]
blueBars = [i / j * 100 for i,j in zip(df['blueBars'], totals)]
 
# plot
barWidth = 0.85
names = ('A','B','C','D','E')

# Create green Bars
plt.bar(r, greenBars, color='#b5ffb9', edgecolor='white', width=barWidth, label="group A")
# Create orange Bars
plt.bar(r, orangeBars, bottom=greenBars, color='#f9bc86', edgecolor='white', width=barWidth, label="group B")
# Create blue Bars
plt.bar(r, blueBars, bottom=[i+j for i,j in zip(greenBars, orangeBars)], color='#a3acff', edgecolor='white', width=barWidth, label="group C")
 
# Custom x axis
plt.xticks(r, names)
plt.xlabel("group")
 
# Add a legend
plt.legend(loc='upper left', bbox_to_anchor=(1,1), ncol=1)
 
# Show graphic
plt.show()
