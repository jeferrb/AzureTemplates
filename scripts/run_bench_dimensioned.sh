#!/bin/bash

# Receive the number of repetitions, the path to the binaries, the number of jobs and the output directory
  # execute all benchs that match the given number of jobs.

#!/bin/bash
# set -x

NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
NUMBER_JOBS=${3}
OUT_DIR=${4}

# run_bench(bench, class, nprocs, repetitions, path)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local path="${5}"
  local out_dir="${6}"
  local name="${bench}.${class}.${nprocs}"
  local logfile="${out_dir}/${name}_native.log"

  if [ ! -e "${path}/${name}" ]; then
    echo "$name does not exists"
    return
  fi

  for i in `seq ${repetitions}`; do
      echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${logfile}"
      date | tee -a "${logfile}"
      mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf stat "${path}/${name}" | tee -a "${logfile}"
      date | tee -a "${logfile}"
    done
}

for binary in $BIN_PATH/*.${NUMBER_JOBS} ; do
  binfile=${binary##*/}
  bench=${binfile:0:2}
  class=${binfile:3:1}
  run_bench $bench $class $NUMBER_JOBS $NUMBER_REPETITIONS $BIN_PATH $OUT_DIR
done
