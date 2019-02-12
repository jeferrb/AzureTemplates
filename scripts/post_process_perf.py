import pandas

df = pandas.read_csv('/Users/jeferson/Desktop/concat_perf_1.csv')

# df=df.head(50)

# max_rows=df.size-2
max_rows=500

print(df)

# for index_row, row in df.iterrows():
# for index_row in range(1, df.size-2):
for index_row in range(1, max_rows):
	# print(row.size/3/4)
	print("----------- row: ", index_row, "-----------")
	# for index_col, column in row.iteritems():
	# for index_col in range(0, row.size, 12):
	for index_col in range(0, df.iloc[index_row,:].size, 12):
	# for index_col in range(0, 24, 12):
		# print(df[;index_col].index(row[index_col+x])   )
		# Select on that size (A) the column of function names 
			# df.iloc[:,index_col+2]
		# Select on that colun where it contains (the most important function (based on the line) )
			# df.iloc[:,index_col+2].str.contains( df.iloc[:,index_col+11][1])
		# Based on the posiction of the function, copy the number of occurences to the right line
		for i in range(0,11,3):
			try:
				value = df.iloc[index_row,index_col+11]
				if (value != '[unknown]'):
					df.iloc[index_row, index_col+i+0] = df[df.iloc[:,index_col+i+2].str.contains(df.iloc[index_row,index_col+11], regex=False, na=False)].iloc[0,index_col+i+1]
			except Exception as e:
				pass
			# print('row: ', index_row , 'col: ', index_col+i)
		# print(df.iloc[:,index_col+2].str.contains(df.iloc[:,index_col+11][1]))
		# df.iloc[index_row, :]
		# print(df[index_col][0])
		# # df2=df.iloc[:,7]
		# # df2[df2.str.contains("372660")]
		# # print(df.iloc[:,10].str.contains())
		# # df[df2.str.contains("429847")]
		# # print(np.where(df2[:]=='429847'))
		# print (index_col)
		# print (row[index_col])
		# idx_col+=1


list=[]
for x in range(0,row.size, 12):
	list.append(1+x)
	list.append(2+x)
	list.append(4+x)
	list.append(5+x)
	list.append(7+x)
	list.append(8+x)
	list.append(10+x)

# df.drop(df.columns[list], axis=1).to_csv('/Users/jeferson/Desktop/concat_perf_new_1.csv', sep=',')

# df.drop(df.columns[list], axis=1).head(max_rows).to_csv('/Users/jeferson/Desktop/concat_perf_new_1.csv', sep=',')
# df2 = df.drop(df.columns[list], axis=1).head(max_rows)

df2 = df.drop(df.columns[list], axis=1)

for x in range(1,max_rows+1): # Add more rows
	df2.loc[-x]=[0]*df2.iloc[1,:].size # adding a row

df2.index = df2.index + max_rows  # shifting index
df2 = df2.sort_index()  # sorting by index

my_list=[]
for index_col in range(0, df2.iloc[1,:].size):
# for index_col in range(0, 1):
	if ((index_col+1)%5==0 and index_col > 0):
		my_list.append(index_col)
		continue
	for x in range(1,max_rows+1):
		# print ('-------x-------', x)
		tot=0
		index_row=max_rows+1
		i=0
		while i < x and index_row < df2.iloc[:,1].size:
			if pandas.isnull(df2.iloc[index_row, index_col]):
				index_row+=1
			# print(index_row, index_col)
			try:
				tot+=int(df2.iloc[index_row, index_col])
			except Exception as e:
				pass
			i+=1
			index_row+=1
		# print (tot)
		df2.iloc[x, index_col] = tot

df2 = df2.drop(df2.columns[my_list], axis=1).head(max_rows).transpose()
df2 = df2.drop(0, axis=1)
df2.to_csv('/Users/jeferson/Desktop/concat_perf_new_2_without-unknown_1.csv', sep=',')



# for index_col in range(0, df2.iloc[index_row,:].size-1):
# 	if ((index_col+1)%5==0 and index_col > 0):
# 		continue
#  	for x in range(1,max_rows):
#  		tot=0
# 		for index_row in range(11, 11+x):
#  			if pandas.isnull(df2.iloc[index_row, index_col]):
#  				index_row+=1
# 			tot+=int(df2.iloc[index_row, index_col])
#  		df2.iloc[x, index_col] = tot

# df.to_csv('/Users/jeferson/Desktop/concat_perf_new_1.csv', sep=',')

'''
for index_col in range(0, df2.iloc[index_row,:].size-1):
	if ((index_col+1)%5==0 and index_col > 0):
		continue
	tot=0
	for index_row in range(11, 11+x):
		if pandas.isnull(df2.iloc[index_row, index_col]):
			continue	
		for x in range(1,max_rows):
			index_row+=1
		tot+=int(df2.iloc[index_row, index_col])
		df2.iloc[x, index_col] = tot
'''

