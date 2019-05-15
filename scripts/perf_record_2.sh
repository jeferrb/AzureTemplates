#!/bin/bash

# Usage: $ mpirun -np 4 ../perf_record_2.sh ../toy2dac/bin/toy2dac

set -x

LOG_FILE=logfile_execution.txt
echo Starting: > $LOG_FILE
date >> $LOG_FILE
# name=`echo $2 | rev | cut -d'/' -f1 | rev`
name=${1##*/}
out_name="${HOME}/${PWD##*/}_${name}-${RANDOM}${RANDOM}.perf.data"
(time perf record -o ${out_name} "$@" ${out_name}) 2>&1 | tee -a $LOG_FILE
echo Ending: >> $LOG_FILE
date >> $LOG_FILE

