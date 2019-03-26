#!/bin/bash

# - - - - - - - - Canários - - - - - - - - - -

# remover perf.data, criando uma nova pasta
find results_2*-01-2019 -type d > dirs.txt
mkdir results_jan_2019_lite
cd results_jan_2019_lite
xargs mkdir -p < ../dirs.txt
cd ../
find results_2*-01-2019 -type f -not -name "*.perf.data" -exec echo cp {} results_jan_2019_lite/{} \; > copy.sh
sh copy.sh



# Process the time between iterations (single infra configuration)
for i in *_native.log; do; cat $i | grep "TIME" | grep -v "Starting" | awk '{print $2}' > ${i}.csv ; done

echo *_native.log.csv | sed 's/ /\t/g' > all_result.csv
paste *_native.log.csv | head -n 500 >> all_result.csv


# Process the time between iterations (multiple results)

for j in results_mygroup2-01-03-2019; do
	for i in ${j}/*_native.log; do
		echo $i
		# cat $i | grep "TIME" | grep -v "Starting" | awk '{print $2}' > ${i}.csv
	done
	echo ${j}/*_native.log.csv | sed 's/ /,/g' > result_concat_${j}.csv
	paste -d ',' ${j}/*_native.log.csv >> result_concat_${j}.csv
done



