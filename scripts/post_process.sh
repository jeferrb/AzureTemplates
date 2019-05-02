#!/bin/bash
# - - - - - - - - GPU - - - - - - - - - -
	RESULT_DIR=results_gpu_`date +%d_%m_%y`_X
	SERVER_IP=""

	mkdir ${RESULT_DIR}
	scp -r username@${SERVER_IP}:/home/username/OpenCL-seismic-processing-tiago/Result ${RESULT_DIR}

	cd ${RESULT_DIR}
	for i in *; do
		if [[  -d "$i" ]] && [[ ! -e result_${i}.txt ]]; then
			find $i -type f -print -iname "*.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; > result_${i}.txt
		fi
	done
	find . -type f -print -iname "*.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; > result_all.txt
	find . -type f -print -iname "*.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; > result_kernel.txt

	# sudiff CRS/CUDA/crs.stack.su CMP/CUDA/cmp.stack.su | suximage
	# sudiff CUDA/crs.stack.su OpenMP/crs.stack.su > diff.su
	# suximage < CRS/CUDA/crs.stack.su &

	less ../116_instances_4_date_31-07-2018_result.log.txt | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tr -d "s" | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" > times.txt
cat times.txt | paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -	 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	# > ../${ls results | grep Standard | head -n1 | rev | cut -d '_' -n -f4- | rev}.times.csv



	# Extract the name of the machine
	head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev
	# Extract the day of the experiment
	head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev


	# get all times from the last execution in the format: bench_name, real, user, sys (from the last process to be executed), real, user, sys (from mpirun)
	for i in *result.log.txt; do
		echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal (1 proc)\tuser (1 proc)\tsys (1 proc)\treal (mpirun)\tuser (mpirun)\tsys (mpirun)" > "${i}.times.csv"
		cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tail -n6272 | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | \
		paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
		awk '{print $1  "\t=" $191 "\t=" $192 "\t=" $193 "\t=" $194 "\t=" $195 "\t=" $196 "\t"}' | sed "s/s\t/\t/g" | sed "s/_native//g" | sort >> ${i}.times.csv
	done

	# the same as above but printing all coluns
	for i in *result.log.txt; do
		echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal (1 proc)\tuser (1 proc)\tsys (1 proc)\treal (mpirun)\tuser (mpirun)\tsys (mpirun)" > "${i}.times.csv"
		cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tail -n6272 | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | \
		paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
		sed "s/ /\t=/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort >> ${i}.times.csv
	done


	# the same as above but printing just real
	for i in *result.log.txt; do
		echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal (1 proc)\treal (mpirun)" > "${i}.times.csv"
		cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tail -n6272 | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | \
		paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
		sed "s/ /\t=/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort | awk '{printf "%s\t", $1; for(i=2;i<=NF;i+=3)printf "%s\t",$i;printf "\n"}' >> ${i}.times.csv
	done


	# the same as above but printing just max, min and average of real time ------ Never gonna work need to calculate the formula
	# for i in *result.log.txt; do
	# 	echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal max (1 proc)\treal min (1 proc)\treal avg (1 proc)\treal\treal (mpirun)" > "${i}.times.csv"
	# 	cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tail -n6272 | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | \
	# 	paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
	# 	sed "s/ /\t=/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort | awk  '{printf "%s\t", $1; max=$2; min=$2;  for(i=2;i<=NF-3;i+=3){if ($i > max) max=$i; if ($i < min) min=$i; total += $i; count++} ; printf "%s\t%s\t%s\t%s\t\n", max, min, total/count, ${NF-2}' >> ${i}.times.csv
	# done

	# awk '{ total += $1; count++ } END { print total/count ; print total}'



# - - - - - - - - MPI - - - - - - - - - -

	# Show Errors:
	# grepr -l "Verification failed\|unable to reliably"
	find . -type f -name "*.*.*.log" -exec grep -l "Verification failed\|unable to reliably" {} \;

	rm result
	find . -type f -name "*.*.*.log" | sort -z | xargs -I % sh -c "echo % >> result ; cat % | grep 'Time in \|Running' >> result;"

	# find . -type f -print  -name "*.*.*.log" -exec sh -c "cat {} | grep 'Time in seconds'" \; | grep -B1 'Time in seconds' | grep -v "\-\-" > time_nas.txt
	find . -type f -print  -name "*.*.*.log" -exec sh -c "grep 'Time in seconds' {}" \; | grep -B1 'Time in seconds' | grep -v "\-\-" | sed 's/Time in seconds = //' | awk '{print $1}' | paste - - - - | sed 's/\.\///' | sed 's/_native\.log//' > time_nas.txt

	# grepr  "Verification " | grep -iv "Successful" | grep -v "Verification being performed"
	# - - - - - - - - Old 	- - - - - - - - - -

	find . -type f -print  -name "*.*.*.log" -exec sh -c "cat {} | grep 'Time in \|Running'" \; > result

	find . -type f -print  -name "*.A.*.log" -exec sh -c "cat {} | grep 'seconds\|Running'" \; > result

	less ../116_instances_4_date_31-07-2018_result.log.txt | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | awk '{print $2}' > times.txt
	less ../116_instances_4_date_31-07-2018_result.log.txt | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2

	for i in *; do
		if [[  -d "$i" ]] && [[ ! -e result_${i}.txt ]]; then
			find $i -type f -print  -name "*\.A\.*\.log" -exec sh -c "cat {} | grep 'seconds\|Running'" \; > result_${i}.txt
		fi
	done


	# - - - - - - - - MatrixMul - - - - - - - - - -

	for i in *; do
	        if [[  -d "$i" ]] && [[ ! -e result_${i}.txt ]]; then
	                find $i -type f -print  -name "*.output" -exec sh -c "cat {} | grep 'Time\|Done:'" \; > result_${i}.txt
	        fi
	done


# - - - - - - - - perf - - - - - - - - - -

	declare -a BENCHS=(bt cg ep ft is lu mg sp)
	declare -a CLASSES=(A B C D)r
	# mkdir results_txt
	for i in results/Standard_*_instances_*_result; do
		local result=`echo $i | rev | cut -d'/' -f1 | cut -c 24- | rev`
		for class in "${CLASSES[@]}"; do
			for bench in "${BENCHS[@]}"; do
				echo ${result}.${bench}.${class}.txt
				find $i -name "${bench}.${class}*.perf.data" -exec sh -c "perf script -i {} 2>/dev/null" \; | awk '{print $7}' | sort | uniq -c | sort -rn >> results_txt/${result}.${bench}.${class}.txt &
			done
			wait
		done
	done

	# find is.D.64 -name "*.perf.data" -exec sh -c "perf script -i {} 2>/dev/null" \; | awk '{print $7}' | sort | uniq -c | sort -n

	# - - - - - - -


	find . -name "mympi*" | xargs du -sh


	for i in *.txt; do
		if [[ -s $i ]]; then
			echo "${i//\./,}" | rev | cut -c 5- | rev > ${i}.filter
			echo ",occurrences,function" >> ${i}.filter
			# grep -v "unknown" $i | head -n 150 | sed 's/^/ /' | sed -r 's/[ ]+/,/g' >> ${i}.filter
			head -n 1000 $i | sed 's/^/ /' | sed -r 's/[ ]+/,/g' >> ${i}.filter
			for lines in $(seq $(cat ${i}.filter | wc -l) 1002); do
				echo ",," >> ${i}.filter
			done
		else
			echo "File $i has no samples"
		fi
	done

	for bench in "${BENCHS[@]}"; do
		paste -d, *.${bench}.*.filter > concat.${bench}.csv
	done
	paste -d, *.filter > concat.csv


	for bench in "${BENCHS[@]}"; do
		for class in "${CLASSES[@]}"; do
			file="${bench}.${class}.all"
			for i in mympi*/${bench}.${class}*; do
				perf script -i $i 2> /dev/null | wc -l
			done | sort >  ${file}
			echo "${bench} ${class}"
			# head -n 1 ${file}; tail -n 1 ${file} ; awk '{ total += $1; count++ } END { print total/count ; print total}' ${file}
			# tail -n 32 ${file} | head -n1
		done
	done > median.all

	for bench in "${BENCHS[@]}"; do
		for class in "${CLASSES[@]}"; do
			file="${bench}.${class}.all"
			tail -n 32 ${file} | head -n1
		done
	done > median.all

	=SUM(A$3:A$1002)
	=100*B3/SUM(B$3:B$1002)
	QUERY(perf_report!1:155,"Select A, B, C where C contains 'binvcrhs'")
	QUERY(perf_report!1:155,"Select * where A contains '"&$A5&"'")



	# for i in *.filter; do
	# 	sed -i '$!s/$/,/' ${i}
	# 	sed -r 's/[ ]+/,/g'
	# done


	# declare -a BENCHS=(bt cg ep ft is lu mg sp)
	# declare -a CLASSES=(A B C D)
	# all_files=""
	# for machine in `ls *.filter | cut -d "." -f 1 | sort | uniq`; do
	# 	for bench in "${BENCHS[@]}"; do
	# 		for class in "${CLASSES[@]}"; do
	# 			echo ${machine}.${bench}.${class}.txt.filter
	# 			all_files+="${machine}.${bench}.${class}.txt.filter "
	# 		done
	# 	done
	# done

	# paste -d, $all_files > concat.csv

	# for i in `seq 1 150`; do
	# 	for file in "*.filter"; do
	# 		echo -n "$i: "
	# 		sed '${i}q;d' ${file}
	# 	done
	# done > all_results.txt


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

	echo *64_native.log.csv | sed 's/ /\t/g' > result.csv
	paste *64_native.log.csv | head -n 500 >> result.csv


	# Process the time between iterations (multiple results)
		for i in ${j}/*64_native.log; do
			cat $i | grep "TIME" | grep -v "Starting" | awk '{print $2}' > ${i}.csv
		done
	for j in Standard_*-01-2019_result; do
		echo ${j}/*64_native.log.csv | sed 's/ /,/g' > result_concat/${j}.csv
		paste -d ',' ${j}/*64_native.log.csv >> result_concat/${j}.csv
	done



	# klp multiple machines
	for result in results_mygroup-klp-2*-04-2019-machine-*/result/source_*.log; do
		echo $result
		echo ${result} > ${result}.csv
		grep TIME $result | awk '{print $2}' >> ${result}.csv
	done
	paste -d, results_mygroup-klp-26-04-2019-machine-*/result/*.csv > klp_results.csv



# toy2dac
# python3 ./scripts/run_scalability_tests_v3.py

cd mymountpoint
for i in results_g-* ;do
	echo $i > result/${i}.csv
	grep ParamountItEnd ${i}/result/toy2dac_exec_1.log | awk '{print $10}' >> result/${i}.csv # delta iterations

paste -d ',' results_g-*/result/*.csv > results_toy2dac_may1.csv
