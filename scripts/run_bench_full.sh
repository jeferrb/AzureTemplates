#!/bin/bash
# set -x

SMALL=
NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
TOTAL_CORES=${3}
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a CLASSES=(A B C D E)
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

  # nohup sar -o "${name}_native.sa" 5 > /dev/null 2>&1 &
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf stat "${path}/${name}" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    echo | tee -a "${name}_native.log"
  done
  
  # killall sar
  # nohup sar -o "${name}_singularity.sa" 5 > /dev/null 2>&1 &

  # for i in `seq ${repetitions}`; do
  #   echo "Running ${name}_singularity (${i}/${repetitions})" | tee -a "${name}_singularity.log"
  #   date | tee -a "${name}_singularity.log"
  #   mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile singularity exec /home/username/ubuntu.img "${path}/${name}" | tee -a "${name}_singularity.log"
  #   date | tee -a "${name}_singularity.log"
  #   echo | tee -a "${name}_singularity.log"
  # done

  # killall sar
}

class=A
bench=cg
  echo "Runing ${bench} ${class} $SIZE"
  run_bench ${bench} "${class}" $SIZE ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}

class=E
bench=is
# for bench in "${BENCHS[@]}"; do
  echo "Runing ${bench} ${class} $SIZE"
  run_bench ${bench} "${class}" $SIZE ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}
# done

for class in "${CLASSES[@]}"; do
  for bench in "${BENCHS[@]}"; do
    echo "Runing ${bench} ${class} $SIZE"
    run_bench ${bench} "${class}" $SIZE ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}
  done
done
# The Data Traffic benchmark (DT) requeires extra paramiters
# Read more at: https://github.com/sbadia/simgrid/tree/master/examples/smpi/NAS/DT
# bench="dt"
# echo "Runing ${bench} ${class} $SIZE"
# run_bench ${bench} "${class}" $SIZE ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}


# if [[ ${SMALL} ]]; then
#   for class in S; do
#     run_bench lu "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench sp "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench sp "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench bt "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench bt "${class}" 16 ${NUMBER_REPETITIONS} ${BIN_PATH}
#   done
#   for class in A B C D; do
#   # for class in A ; do # B C D; do
#     run_bench lu "${class}" 32 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench sp "${class}" 25 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench sp "${class}" 36 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench bt "${class}" 25 ${NUMBER_REPETITIONS} ${BIN_PATH}
#     run_bench bt "${class}" 36 ${NUMBER_REPETITIONS} ${BIN_PATH}
#   done
# fi
