#!/bin/bash

# Receive the number of repetitions, the path to the binaries, the number of jobs and the output directory
  # execute all benchs that match the given number of jobs.

set -x

NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
NUMBER_JOBS=${3}
OUT_DIR=${4}
OUT_DIR="$HOME/mymountpoint${OUT_DIR##*mymountpoint}"
BIN_FILE=$HOME/toy2dac/bin/toy2dac
name="${BIN_FILE##*/}"


for i in `seq ${NUMBER_REPETITIONS}`; do
    logfile="${OUT_DIR}/${name}_${PWD##*/}_exec_${i}.log"
    echo "Running ${name}_native (${i}/${NUMBER_REPETITIONS})" | tee -a "${logfile}"
    echo "TIME_STARTING: " | tee -a "${logfile}"
    date | tee -a "${logfile}"
    (time mpirun -n "${NUMBER_JOBS}" -machine ~/machines ${BIN_FILE}) |& tee -a "${logfile}"
    echo "TIME_ENDING: " | tee -a "${logfile}"
    date | tee -a "${logfile}"
    cp -r ${PWD} ${OUT_DIR}/result_${PWD##*/}_execution_${i}
done
