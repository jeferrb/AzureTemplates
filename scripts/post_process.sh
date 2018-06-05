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
