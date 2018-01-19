#!/bin/sh
set -x

NUMBER_REPETITIONS=${1}
SUBNET_HOSTS=${2}
BIN_PATH=${3}

# run_bench(bench, class, nprocs, repetitions, hosts, path)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local hosts="${5}"
  local path="${6}"
  local name="${bench}.${class}.${nprocs}"

  nohup sar -o "${name}.sa" 5 > /dev/null 2>&1 &
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name} (${i}/${repetitions})" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    mpirun -np "${nprocs}"  -host "${hosts}" "${path}${name}" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    echo | tee -a "${name}.log"
  done

  killall sar
}

for class in A B C D; do
    echo "The cool class is ${class}"
    run_bench lu "${class}" 32 ${NUMBER_REPETITIONS} ${SUBNET_HOSTS} ${BIN_PATH}
    run_bench sp "${class}" 25 ${NUMBER_REPETITIONS} ${SUBNET_HOSTS} ${BIN_PATH}
    run_bench sp "${class}" 36 ${NUMBER_REPETITIONS} ${SUBNET_HOSTS} ${BIN_PATH}
    run_bench bt "${class}" 25 ${NUMBER_REPETITIONS} ${SUBNET_HOSTS} ${BIN_PATH}
    run_bench bt "${class}" 36 ${NUMBER_REPETITIONS} ${SUBNET_HOSTS} ${BIN_PATH}
done