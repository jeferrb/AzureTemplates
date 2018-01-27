#!/bin/bash
set -x

SMALL=
NUMBER_REPETITIONS=${1}
BIN_PATH=${2}

# run_bench(bench, class, nprocs, repetitions, path)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local path="${5}"
  local name="${bench}.${class}.${nprocs}"

  nohup sar -o "${name}.sa" 5 > /dev/null 2>&1 &
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile "${path}${name}" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    echo | tee -a "${name}_native.log"
  done
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name}_singularity (${i}/${repetitions})" | tee -a "${name}_singularity.log"
    date | tee -a "${name}_singularity.log"
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile singularity exec /home/username/ubuntu.img "${path}${name}" | tee -a "${name}_singularity.log"
    date | tee -a "${name}_singularity.log"
    echo | tee -a "${name}_singularity.log"
  done

  killall sar
}

if [[ ${SMALL} ]]; then
  for class in S; do
    run_bench lu "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench sp "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench sp "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench bt "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench bt "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
  done
else
  for class in A B C D; do
    run_bench lu "${class}" 32 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench sp "${class}" 25 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench sp "${class}" 36 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench bt "${class}" 25 ${NUMBER_REPETITIONS} ${BIN_PATH}
    run_bench bt "${class}" 36 ${NUMBER_REPETITIONS} ${BIN_PATH}
  done
fi
