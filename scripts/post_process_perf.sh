# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# DO NOT EXCUTE THIS SCRIPT, IT HAS JUST CLUES OF HOW TO PROCESS THE DATA!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# - - - - - - - - TIME: Create CSV from _result.log.txt - - - - - - - - - -

less ../116_instances_4_date_31-07-2018_result.log.txt | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | tr -d "s" | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" > times.txt
cat times.txt | paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# > ../${ls results | grep Standard | head -n1 | rev | cut -d '_' -n -f4- | rev}.times.csv

# Extract the name of the machine
head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev
# Extract the day of the experiment
head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev


# # get all times from the last execution in the format: bench_name, real, user, sys (from the last process to be executed), real, user, sys (from mpirun)
# for i in *result.log.txt; do
# 	echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal (1 proc)\tuser (1 proc)\tsys (1 proc)\treal (mpirun)\tuser (mpirun)\tsys (mpirun)" > "${i}.times.csv"
# 	cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | awk 'NF' | \
# 	paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
# 	awk '{print $1  "\t=" $191 "\t=" $192 "\t=" $193 "\t=" $194 "\t=" $195 "\t=" $196 "\t"}' | sed "s/s\t/\t/g" | sed "s/_native//g" | sort >> ${i}.times.csv
# done

# # the same as above but printing all coluns
# for i in *result.log.txt; do
# 	echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\treal (1 proc)\tuser (1 proc)\tsys (1 proc)\treal (mpirun)\tuser (mpirun)\tsys (mpirun)" > "${i}.times.csv"
# 	cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | awk 'NF' | \
# 	paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
# 	sed "s/ /\t=/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort >> ${i}.times.csv
# done


# # the same as above but printing just real
# for i in results/*result.log.txt; do
# 	destination=`echo cat ${i} | rev | cut -d"/" -f1 | rev`
# 	echo "`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`\tMedian\tAverage\tMax\tMin\tMpirun\treal (1 proc)\treal (mpirun)" > "${i}.times.csv"
# 	cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | sed "s/m/*60+/g" | sed "s/*60+g/mg/g" | awk 'NF' | \
# 	paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
# 	sed "s/ /\t=/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort | awk 'BEGIN{count=2} {printf "%s\t=MEDIAN(G%s:BR%s)\t=AVERAGE(G%s:BR%s)\t=MAX(G%s:BR%s)\t=MIN(G%s:BR%s)\t=BS%s\t", $1, count, count, count, count, count, count, count, count, count; count++ ; for(i=2;i<=NF;i+=3)printf "%s\t",$i;printf "\n"}' >> results_txt/${destination}.times.csv
# done

# the same as above but computing the max
declare -a VM_SIZES=("Basic_A0" "Basic_A1" "Basic_A2" "Basic_A3" "Basic_A4" "Standard_A0" "Standard_A1" "Standard_A1_v2" "Standard_A10" "Standard_A11" "Standard_A2" "Standard_A2_v2" "Standard_A2m_v2" "Standard_A3" "Standard_A4" "Standard_A4_v2" "Standard_A4m_v2" "Standard_A5" "Standard_A6" "Standard_A7" "Standard_A8" "Standard_A8_v2" "Standard_A8m_v2" "Standard_A9" "Standard_B1ms" "Standard_B1s" "Standard_B2ms" "Standard_B2s" "Standard_B4ms" "Standard_B8ms" "Standard_D1" "Standard_D1_v2" "Standard_D11" "Standard_D11_v2" "Standard_D11_v2_Promo" "Standard_D12" "Standard_D12_v2" "Standard_D12_v2_Promo" "Standard_D13" "Standard_D13_v2" "Standard_D13_v2_Promo" "Standard_D14" "Standard_D14_v2" "Standard_D14_v2_Promo" "Standard_D15_v2" "Standard_D16_v3" "Standard_D16s_v3" "Standard_D2" "Standard_D2_v2" "Standard_D2_v2_Promo" "Standard_D2_v3" "Standard_D2s_v3" "Standard_D3" "Standard_D3_v2" "Standard_D3_v2_Promo" "Standard_D32_v3" "Standard_D32s_v3" "Standard_D4" "Standard_D4_v2" "Standard_D4_v2_Promo" "Standard_D4_v3" "Standard_D4s_v3" "Standard_D5_v2" "Standard_D5_v2_Promo" "Standard_D64_v3" "Standard_D64s_v3" "Standard_D8_v3" "Standard_D8s_v3" "Standard_DS1" "Standard_DS1_v2" "Standard_DS11" "Standard_DS11_v2" "Standard_DS11_v2_Promo" "Standard_DS12" "Standard_DS12_v2" "Standard_DS12_v2_Promo" "Standard_DS13" "Standard_DS13_v2" "Standard_DS13_v2_Promo" "Standard_DS13-2_v2" "Standard_DS13-4_v2" "Standard_DS14" "Standard_DS14_v2" "Standard_DS14_v2_Promo" "Standard_DS14-4_v2" "Standard_DS14-8_v2" "Standard_DS15_v2" "Standard_DS2" "Standard_DS2_v2" "Standard_DS2_v2_Promo" "Standard_DS3" "Standard_DS3_v2" "Standard_DS3_v2_Promo" "Standard_DS4" "Standard_DS4_v2" "Standard_DS4_v2_Promo" "Standard_DS5_v2" "Standard_DS5_v2_Promo" "Standard_E16_v3" "Standard_E16s_v3" "Standard_E2_v3" "Standard_E2s_v3" "Standard_E32_v3" "Standard_E32-16s_v3" "Standard_E32-8s_v3" "Standard_E32s_v3" "Standard_E4_v3" "Standard_E4s_v3" "Standard_E64_v3" "Standard_E64-16s_v3" "Standard_E64-32s_v3" "Standard_E64s_v3" "Standard_E8_v3" "Standard_E8s_v3" "Standard_F1" "Standard_F16" "Standard_F16s" "Standard_F1s" "Standard_F2" "Standard_F2s" "Standard_F4" "Standard_F4s" "Standard_F8" "Standard_F8s" "Standard_H16" "Standard_H16m" "Standard_H16mr" "Standard_H16r" "Standard_H8" "Standard_H8m" "Standard_NC12" "Standard_NC12s_v2" "Standard_NC24" "Standard_NC24r" "Standard_NC24rs_v2" "Standard_NC24s_v2" "Standard_NC6" "Standard_NC6s_v2" "Standard_NV12" "Standard_NV24" "Standard_NV6" "Standard_F2s_v2" "Standard_F4s_v2" "Standard_F8s_v2" "Standard_F16s_v2" "Standard_F32s_v2" "Standard_F64s_v2" "Standard_F72s_v2")
for i in results/*result.log.txt; do
	local destination=`echo cat ${i} | rev | cut -d"/" -f1 | rev`
	local position=`echo ${destination} | cut -d "_" -f1`
	if [ -n "$ZSH_VERSION" ]; then
		position=`echo ${position} + 1 | bc`
	fi
	destination="results_txt/${VM_SIZES[${position}]}.time.csv"
	echo "Max\t`head -n 11 ${i} | tail -n 1 | rev | cut -d "=" -f 1 | rev`-`head -n 17 ${i} | tail -n 1 | rev | cut -d"_" -f 2 | rev`" > ${destination}
	cat ${i} | grep 'real\|user\|sys\|Running' | grep -v 'echo\|username' | grep real -B1 -A2 | awk '{print $2}' | sed "s/m/ /g" | sed "s/_perf//g" | sed "s/ g/mg/g" | awk 'NF' | \
	paste -d " " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | \
	sed "s/ /\t/g" | sed "s/s\t/\t/g" | sed "s/s$//g" | sed "s/_native//g" | sort | awk '{max=0; for(i=2;i<=NF-9;i++){current=$i * 60; i++; current+=$i; if(current > max){max=current}}; printf "%s\t%s\n", $1, max;}' >> ${destination}
done

paste results_txt/*.time.csv | awk '{if (NR==1 || (NR+1)%3 ==0 ) {printf "%s\t",$1; for(i=2;i<=NF;i+=2){ printf "%s\t",$i;}; printf "\n"}}' > results_txt/all.times.csv

# paste results_txt/*.time.csv | awk '{if(NR==1){bench=$2}; if (NR==1 || (NR+1)%3 ==0 ) {printf "%s\t%s\t", bench, $1; for(i=2;i<=NF;i+=2){ printf "%s\t",$i;}; printf "\n"}}' > results_txt/all.times.csv

cat results_txt/all.times.csv | awk 'BEGIN{bench=0} {if(NR==1){bench=$2};for(i=2;i<=NF;i++){printf "%s\t%s\n",bench, $i;}}'

# echo "bench\tclass" > order.csv
# for i in `seq 1 3; do
# 	for class in "${CLASSES[@]}"; do
# 		for bench in "${BENCHS[@]}"; do
# 			echo "${bench}\t${class}" >> order.csv
# 		done
# 	done
# done

#  Convert numbers to the Azure Name
# declare -a VM_SIZES=("Basic_A0" "Basic_A1" "Basic_A2" "Basic_A3" "Basic_A4" "Standard_A0" "Standard_A1" "Standard_A1_v2" "Standard_A10" "Standard_A11" "Standard_A2" "Standard_A2_v2" "Standard_A2m_v2" "Standard_A3" "Standard_A4" "Standard_A4_v2" "Standard_A4m_v2" "Standard_A5" "Standard_A6" "Standard_A7" "Standard_A8" "Standard_A8_v2" "Standard_A8m_v2" "Standard_A9" "Standard_B1ms" "Standard_B1s" "Standard_B2ms" "Standard_B2s" "Standard_B4ms" "Standard_B8ms" "Standard_D1" "Standard_D1_v2" "Standard_D11" "Standard_D11_v2" "Standard_D11_v2_Promo" "Standard_D12" "Standard_D12_v2" "Standard_D12_v2_Promo" "Standard_D13" "Standard_D13_v2" "Standard_D13_v2_Promo" "Standard_D14" "Standard_D14_v2" "Standard_D14_v2_Promo" "Standard_D15_v2" "Standard_D16_v3" "Standard_D16s_v3" "Standard_D2" "Standard_D2_v2" "Standard_D2_v2_Promo" "Standard_D2_v3" "Standard_D2s_v3" "Standard_D3" "Standard_D3_v2" "Standard_D3_v2_Promo" "Standard_D32_v3" "Standard_D32s_v3" "Standard_D4" "Standard_D4_v2" "Standard_D4_v2_Promo" "Standard_D4_v3" "Standard_D4s_v3" "Standard_D5_v2" "Standard_D5_v2_Promo" "Standard_D64_v3" "Standard_D64s_v3" "Standard_D8_v3" "Standard_D8s_v3" "Standard_DS1" "Standard_DS1_v2" "Standard_DS11" "Standard_DS11_v2" "Standard_DS11_v2_Promo" "Standard_DS12" "Standard_DS12_v2" "Standard_DS12_v2_Promo" "Standard_DS13" "Standard_DS13_v2" "Standard_DS13_v2_Promo" "Standard_DS13-2_v2" "Standard_DS13-4_v2" "Standard_DS14" "Standard_DS14_v2" "Standard_DS14_v2_Promo" "Standard_DS14-4_v2" "Standard_DS14-8_v2" "Standard_DS15_v2" "Standard_DS2" "Standard_DS2_v2" "Standard_DS2_v2_Promo" "Standard_DS3" "Standard_DS3_v2" "Standard_DS3_v2_Promo" "Standard_DS4" "Standard_DS4_v2" "Standard_DS4_v2_Promo" "Standard_DS5_v2" "Standard_DS5_v2_Promo" "Standard_E16_v3" "Standard_E16s_v3" "Standard_E2_v3" "Standard_E2s_v3" "Standard_E32_v3" "Standard_E32-16s_v3" "Standard_E32-8s_v3" "Standard_E32s_v3" "Standard_E4_v3" "Standard_E4s_v3" "Standard_E64_v3" "Standard_E64-16s_v3" "Standard_E64-32s_v3" "Standard_E64s_v3" "Standard_E8_v3" "Standard_E8s_v3" "Standard_F1" "Standard_F16" "Standard_F16s" "Standard_F1s" "Standard_F2" "Standard_F2s" "Standard_F4" "Standard_F4s" "Standard_F8" "Standard_F8s" "Standard_H16" "Standard_H16m" "Standard_H16mr" "Standard_H16r" "Standard_H8" "Standard_H8m" "Standard_NC12" "Standard_NC12s_v2" "Standard_NC24" "Standard_NC24r" "Standard_NC24rs_v2" "Standard_NC24s_v2" "Standard_NC6" "Standard_NC6s_v2" "Standard_NV12" "Standard_NV24" "Standard_NV6" "Standard_F2s_v2" "Standard_F4s_v2" "Standard_F8s_v2" "Standard_F16s_v2" "Standard_F32s_v2" "Standard_F64s_v2" "Standard_F72s_v2")
# for i in results_txt/*result.log.txt.times.csv; do
# 	local position=`echo ${i} | cut -d "_" -f1`
# 	if [ -n "$ZSH_VERSION" ]; then
# 		position=`echo ${position} + 1 | bc`
# 	fi
# 	# echo $position
# 	cp ${i} "${VM_SIZES[${position}]}.time.csv" 
# 	# paste -d "\t" order.csv ${i} > "${VM_SIZES[${position}]}.time.csv"
# done


for i in mymp*/bt.C.64*.perf.data; do;
	echo $i
	perf script -i $i 2>/dev/null  | head -n 1 | awk '{print $3}'
done | sort

# ls order.csv Standard_*.csv | xargs paste -d "\t" > all_times.csv


# - - - - - - - - Execution check - - - - - - - - - -

# Show Errors:
# grepr -l "Verification failed\|unable to reliably"
find . -type f -name "*.*.*.log" -exec grep -l "Verification failed\|unable to reliably" {} \;

# find is.D.64 -name "*.perf.data" -exec sh -c "perf script -i {} 2>/dev/null" \; | awk '{print $7}' | sort | uniq -c | sort -n

#  Check the size of all perf.data
find . -name "mympi*" | xargs du -sh

# Check the number of samples of an execution
for bench in "${BENCHS[@]}"; do
	for class in "${CLASSES[@]}"; do
		file="${bench}.${class}.all"
		for i in mympi*/${bench}.${class}*; do
			perf script -i $i 2> /dev/null | wc -l
		done | sort >  ${file}
		echo "${bench} ${class}"
		head -n 1 ${file}; tail -n 1 ${file} ; awk '{ total += $1; count++ } END { print total/count ; print total}' ${file}
		# tail -n 32 ${file} | head -n1
	done
done > median.all


# - - - - - - - - Colect time reported by the benchmark - - - - - - - - - -

rm time_nas.txt; find . -type f -name "*.*.*.log" | sort -z | xargs -I % sh -c "echo % >> time_nas.txt ; cat % | grep 'Time in \|Running' >> time_nas.txt;"

# Version 2
find . -type f -print  -name "*.*.*.log" -exec sh -c "grep 'Time in seconds' {}" \; | grep -B1 'Time in seconds' | grep -v "\-\-" > time_nas.txt

# - - - - - - - - Old - - - - - - - - - -

# - - - - - - - - Perf: Generate text files from perf.data - - - - - - - - - -


# Sort executions to the right place
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a CLASSES=(A B C D)
for i in Standard_*_result; do
	mkdir ${i}/perf_data
	for class in "${CLASSES[@]}"; do
		for bench in "${BENCHS[@]}"; do
			for j in ${i}/mymp*/${bench}.${class}.64-*.perf.data; do;
				echo $j
				perf script -i $j 2>/dev/null  | head -n 1 | awk '{print $3}'
			done > file.tmp.txt
			local index=64
			local sentinela=0
			for j in `cat file.tmp.txt | paste -d" " - - | awk '{printf "%s\t%s\n", $2, $1}' | sort | awk '{print $2}'`; do
				echo "${i}/perf_data/execution_${sentinela}/$j"
				if [[ index -eq 64 ]]; then
					index=0
					sentinela=$((sentinela+1))
					mkdir "${i}/perf_data/execution_${sentinela}"
				fi
					echo "mv ${i}/perf_data/execution_${sentinela}/`echo $j | rev | cut -d"/" -f 1 | rev` $j" >> revert.sh
					mv $j "${i}/perf_data/execution_${sentinela}"
					index=$((index+1))
			done
			rm file.tmp.txt
		done
	done
done

# rm -rf Standard_*_result/perf_data


declare -a BENCHS=(bt cg ep ft is lu mg sp)
# declare -a BENCHS=(lu)
declare -a CLASSES=(A B C D)
# mkdir results_txt
for i in results/Standard_*_instances_*_result; do
	local result=`echo $i | rev | cut -d'/' -f1 | cut -c 24- | rev`
	for execution in ${i}/perf_data/execution_*; do
		local exec_num=`echo $execution | rev | cut -d"_" -f 1 | rev`
		for class in "${CLASSES[@]}"; do
			for bench in "${BENCHS[@]}"; do
				echo ${result}.${bench}.${class}_${exec_num}.txt
				find $execution -name "${bench}.${class}*.perf.data" -exec sh -c "perf script -i {} 2>/dev/null" \; | awk '{print $7}' | sort | uniq -c | sort -rn >> results_txt/${result}.${bench}.${class}_${exec_num}.txt &
			done
			wait
		done
	done
done


# Post-process the data generate by the code above to filter it
for i in results_txt/*.txt; do
	if [[ -s $i ]]; then
		echo "${i//\./,}" | rev | cut -c 5- | cut -d "/" -f1 | rev | tee ${i}.filter
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

# Concatenate all filtered data compuse a CSV of all benchmark executions
for execution in `seq 1 3`; do
	paste -d, results_txt/*_${execution}.txt.filter > results_txt/concat_perf_${execution}.csv
done
# Concatenate all filtered data compuse a CSV for each benchmark
for execution in `seq 1 3`; do
	for bench in "${BENCHS[@]}"; do
		paste -d, results_txt/*.${bench}.*_${execution}.txt.filter > results_txt/concat_perf.${bench}_${execution}.csv
	done
done



#  Perf analysis
# declare -a BENCHS=(lu)
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a FREQUENCES=(9000 2200 400 40) # samples per second
declare -a CLASSES=(A B C D)
for i in results/*/perf_data/execution_*; do
	for bench in "${BENCHS[@]}"; do
		for (( thisClass=1; thisClass<=4; thisClass++ )); do
			for (( time = 1; time < 10; time++)); do
				samples=$((${FREQUENCES[$thisClass]} * ${time} * 30)) # increase every 30 seconds
				samples=${samples/\./}
				echo ${i}/${bench}.${CLASSES[$thisClass]}.64.${samples}samples.txt
				for process in ${i}/${bench}.${CLASSES[$thisClass]}.64-*.perf.data; do
					perf script -i $process 2> /dev/null | head -n $samples | awk '{print $7}'
					# echo 1
				done | sort | uniq -c | sort -n | tail -n 10 > ${i}/${bench}.${CLASSES[$thisClass]}.64.${samples}samples.txt &
			done
			wait
		done
	done
done


for i in results/*/perf_data/execution_*/*.txt; do
	(echo "`echo  $i | rev | cut -d"/" -f1 | cut -d"." -f3- | rev`\t`echo  $i | rev | cut -d"/" -f1 | cut -d"." -f2 | rev`" ; cat $i | awk '{printf "%s\t%s\n", $1, $2}' ) > ${i}.filter 
done
for i in results/*/perf_data/execution_*; do
	destination=`echo cat ${i} | rev | cut -d"/" -f3 | rev`
	paste ${i}/*.txt.filter > ${i}/top_functions_${destination}.filter2
done


function myFunc {
	declare -a LETTERS=(' ' A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
	flag=1
	for i in `seq 1 27`; do
		for j in `seq $flag 27`; do
			for k in `seq 2 27`; do
				echo "${LETTERS[$i]}${LETTERS[$j]}${LETTERS[$k]}"
				if [[ $i -eq 2 ]] && [[ $j -eq 15 ]] && [[ $k -eq 17 ]]; then
					return
				fi
			done
		done
		flag=2
	done
}


# Post-process on progress
for i in results_txt/*.txt; do
	if [[ -s $i ]]; then
		echo "${i//\./,}" | rev | cut -c 5- | cut -d "/" -f1 | rev | tee ${i}.filter
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

vals=($(myFunc))

for i in `seq 1 ${#vals[@]}`; do
	echo ${vals[$i]}
done




#  Perf analysis
samplesPerMinute=$((40 * 60)) # increase every 60 seconds
samplesPerMinute=${samplesPerMinute/\./}

# grab all the fist 5 minuts of execution to text files
for process in results/*/perf_data/execution_*/*.D.64-*.perf.data; do
	echo processing $process
	perf script -i $process 2> /dev/null | head -n $((${samplesPerMinute} * 5)) > ${process}.5min.txt
	# rm ${process}.10min.txt
done

# declare -a BENCHS=(bt)
declare -a BENCHS=(bt cg ep ft is lu mg sp)
for i in results/*/perf_data/execution_*; do
	for bench in "${BENCHS[@]}"; do
		for (( minutes = 1; minutes < 6; minutes++ )); do
			lastSample=$((${samplesPerMinute} * minutes))
			echo ${i}/${bench}.D.64.${lastSample}samples.txt
			echo "$i ${bench}.D.64.${lastSample}samples" | sed "s/\// /g" | awk '{print $2 "," $5}' > ${i}/${bench}.D.64.${minutes}min.csv
			echo "$i ${bench}.D.64.${samplesPerMinute}samples" | sed "s/\// /g" | awk '{print $2 "," $5}' > ${i}/${bench}.D.64.1min${minutes}.csv
			for process in ${i}/${bench}.D.64-*.perf.data.5min.txt; do
				cat ${process} | head -n $lastSample | awk '{print $7}'
				# ls ${process}
			done | sort | uniq -c | sort -rn | awk '{print $2","$1}' >> ${i}/${bench}.D.64.${minutes}min.csv &
			for process in ${i}/${bench}.D.64-*.perf.data.5min.txt; do
				cat ${process} | head -n $lastSample | tail -n ${samplesPerMinute} | awk '{print $7}'
				# ls ${process}
			done | sort | uniq -c | sort -rn | awk '{print $2","$1}' >> ${i}/${bench}.D.64.1min${minutes}.csv &
		done
		wait
	done
done

max_line=`wc -l results/*/perf_data/execution_*/*.D.64.*min*.csv | sort -n | tail -n2 | head -n1 | awk '{print $1}'`
for i in results/*/perf_data/execution_*/*.D.64.*min*.csv; do
	echo ${i}
	for lines in $(seq `wc -l ${i} | awk '{print $1}'` $max_line); do
		echo "," >> ${i}
	done
done

ulimit -Hn 10240 # The hard limit
ulimit -Sn 10240 # The soft limit
paste -d ',' results/*/perf_data/execution_*/*.D.64.*min.csv > results_txt/all_benchs.D.64.sun_minutes.csv
paste -d ',' results/*/perf_data/execution_*/*.D.64.*min?.csv > results_txt/all_benchs.D.64.1_minute.csv


# head -n $lastSample | awk '{print $7}' | sort | uniq -c | sort -n -r | awk '{print $2","$1}' > tmp; paste -d, tbl.csv tmp > a.csv; mv a.csv tbl.csv






# for i in 10000 20000 30000 40000 50000; do ; done


