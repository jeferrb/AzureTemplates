#!/bin/bash

# Receive the number of repetitions, the path to the binaries, the number of jobs and the output directory
  # execute all benchs that match the given number of jobs.

#!/bin/bash
set -x

PATH=/home/ubuntu/bin:/home/ubuntu/.local/bin:/opt/intel/advisor_2018.3.0.558307/bin64:/opt/intel/vtune_amplifier_2018.3.0.558279/bin64:/opt/intel/inspector_2018.3.0.558189/bin64:/opt/intel/itac/2018.3.022/intel64/bin:/opt/intel/itac/2018.3.022/intel64/bin:/opt/intel/clck/2018.3/bin/intel64:/opt/intel/compilers_and_libraries_2018.3.222/linux/bin/intel64:/opt/intel/compilers_and_libraries_2018.3.222/linux/mpi/intel64/bin:/opt/intel/compilers_and_libraries_2018.3.222/linux/bin/intel64:/opt/intel/compilers_and_libraries_2018.3.222/linux/mpi/intel64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/intel/parallel_studio_xe_2018.3.051/bin

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
