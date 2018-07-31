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


# - - - - - - - - MPI - - - - - - - - - -
# Show Errors:
grepr -l "Verification failed\|unable to reliably"

rm result
find . -type f -name "*.*.*.log" | sort -z | xargs -I % sh -c "echo % >> result ; cat % | grep 'Time in \|Running' >> result;"

# grepr  "Verification " | grep -iv "Successful" | grep -v "Verification being performed"
# - - - - - - - - Old - - - - - - - - - -

find . -type f -print  -name "*.*.*.log" -exec sh -c "cat {} | grep 'Time in \|Running'" \; > result

find . -type f -print  -name "*.A.*.log" -exec sh -c "cat {} | grep 'seconds\|Running'" \; > result

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
declare -a CLASSES=(A B C D)
mkdir results_txt
for i in results/*; do
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



for i in *.txt; do
	if [[ -s $i ]]; then
		echo "${i//\./,}" | rev | cut -c 5- | rev > ${i}.filter
		echo ",occurrences,function" >> ${i}.filter
		grep -v "unknown" $i | head -n 150 | sed 's/^/ /' | sed -r 's/[ ]+/,/g' >> ${i}.filter
		for lines in $(seq $(cat ${i}.filter | wc -l) 152); do
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

=SUM(A$3:A$155)
=100*B3/SUM(B$3:B$152)
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


