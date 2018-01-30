#!/bin/bash
# - - - - - - - - GPU - - - - - - - - - -
RESULT_DIR=results_gpu_`date +%d_%m_%y`_X
SERVER_IP=""

mkdir ${RESULT_DIR}
scp -r username@${SERVER_IP}:/home/username/OpenCL-seismic-processing-tiago/Result ${RESULT_DIR}

cd ${RESULT_DIR}
find . -type f -print -iname "*5.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; >> result




# - - - - - - - - MPI - - - - - - - - - -
find . -type f -print  -name "*.txt" -exec sh -c "cat {} | grep 'seconds\|Running'" \;