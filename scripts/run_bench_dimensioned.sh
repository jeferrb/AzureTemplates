#!/bin/bash

# Receive the number of repetitions, the path to the binaries and the number of jobs
  # execute all benchs that match this jobs.

#!/bin/bash
# set -x

SMALL=
NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
NUMBER_JOBS=${3}
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a CLASSES=(A B C D E)
NPB_JOBS=64

# run_bench(bench, class, nprocs, repetitions, path)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local path="${5}"
  local nprocessors="${6}"
  local name="${bench}.${class}.${nprocs}"

  if [ ! -e "${path}/${name}" ]; then
    echo "$name does not exists"
    return
  fi


for i in `seq ${repetitions}`; do
    echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf stat "${path}/${name}" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    echo | tee -a "${name}_native.log"
  done
}

for binary in $BIN_PATH/*.${NUMBER_JOBS} ; do
  binfile=${binary##*/}
  bench=${binfile:0:2}
  class=${binfile:3:1}
  run_bench $bench $class $NUMBER_JOBS $NUMBER_REPETITIONS $BIN_PATH
done
