import pandas

df = pandas.read_csv('/Users/jeferson/Desktop/concat_perf_1.csv')

df=df.head(50)

print(df)

# for index_row, row in df.iterrows():
# for index_row in range(1, df.size-2):
for index_row in range(1, 10):
	# print(row.size/3/4)
	print("----------- row: ", index_row, "-----------")
	idx_col = 0
	# for index_col, column in row.iteritems():
	for index_col in range(0, row.size, 12): 
	# for index_col in range(0, 24, 12):
		# print(df[;index_col].index(row[index_col+x])   )
		# Select on that size (A) the column of function names 
			# df.iloc[:,index_col+2]
		# Select on that colun where it contains (the most important function (based on the line) )
			# df.iloc[:,index_col+2].str.contains( df.iloc[:,index_col+11][1])
		# Based on the posiction of the function, copy the number of occurences to the right line
		for i in range(0,11,3):
			try:
				df.iloc[index_row, index_col+i+0] = df[df.iloc[:,index_col+i+2].str.contains(df.iloc[index_row,index_col+11], regex=False, na=False)].iloc[0,index_col+i+1]
			except Exception as e:
				pass
			print('row: ', index_row , 'col: ', index_col+i)
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


df.to_csv('/Users/jeferson/Desktop/concat_perf_new_1.csv', sep=',')