#!/bin/bash

# Receive the number of repetitions, the path to the binaries, the number of jobs and the output directory
  # execute all benchs that match the given number of jobs.

#!/bin/bash
set -x

NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
NUMBER_JOBS=${3}
OUT_DIR=${4}
OUT_DIR="$HOME/mymountpoint${OUT_DIR##*mymountpoint}"
BIN_FILE=$HOME/toy2dac/bin/toy2dac
name="${BIN_FILE##*/}"


# if [ ! -e "${BIN_PATH}/" ]; then
#     echo "$BIN_PATH does not exists"
#     return
# fi
# cd "${BIN_PATH}"

for i in `seq ${NUMBER_REPETITIONS}`; do
    logfile="${OUT_DIR}/${name}_exec_${i}.log"
    echo "Running ${name}_native (${i}/${NUMBER_REPETITIONS})" | tee -a "${logfile}"
    echo "TIME_STARTING: " | tee -a "${logfile}"
    date | tee -a "${logfile}"
    # mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf stat "${path}/${name}" | tee -a "${logfile}"
    # time mpirun -n 16 -ppn 8 -genv OMP_NUM_THREADS=2 -genv I_MPI_PIN_DOMAIN=omp -machine ~/machines ~/toy2dac/bin/toy2dac
    time mpirun -n "${NUMBER_JOBS}" -machine ~/machines ${BIN_FILE} |& tee -a "${logfile}"
    echo "TIME_ENDING: " | tee -a "${logfile}"
    date | tee -a "${logfile}"
done
