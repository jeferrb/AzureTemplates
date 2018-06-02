#!/bin/bash
# set -x

SMALL=
NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
TOTAL_CORES=${3}
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a CLASSES=(A B C D)
# declare -a BENCHS=(bt)
# declare -a CLASSES=(A)
SIZE=64

# run_bench(bench, class, nprocs, repetitions, path, nprocessors)
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

  nohup sar -o "${name}_native.sa" 5 > /dev/null 2>&1 &
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf record -m 10000000000000 -o "${name}.perf.data" "${path}/${name}" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    echo | tee -a "${name}_native.log"
  done
  
  killall sar
}

for class in "${CLASSES[@]}"; do
  for bench in "${BENCHS[@]}"; do
    echo "Runing ${bench} ${class} $SIZE"
    run_bench ${bench} "${class}" $SIZE ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}
  done
done
