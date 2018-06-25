#!/bin/bash
set -x

SMALL=
NUMBER_REPETITIONS=${1}
BIN_PATH=${2}
TOTAL_CORES=${3}
declare -a BENCHS=(bt cg ep ft is lu mg sp)
declare -a CLASSES=(A) #B C D)
declare -a FREQUENCES=(9000 2200 400 40)
# declare -a BENCHS=(bt)
# declare -a CLASSES=(A)
NUM_PROC=64

# run_bench(bench, class, nprocs, repetitions, path, nprocessors, frequence)
run_bench_stats() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local path="${5}"
  local nprocessors="${6}"
  local frequence="${7}"
  local name="${bench}.${class}.${nprocs}"

  if [ ! -e "${path}/${name}" ]; then
    echo "$name does not exists"
    return
  fi

  
  for i in `seq ${repetitions}`; do
    nohup sar -o "${name}_native_rep-${i}.sa" 5 > /dev/null 2>&1 &
    echo "Running ${name}_native (${i}/${repetitions})" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    # mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile perf record -m 512G -o "${name}.perf.data" "${path}/${name}" | tee -a "${name}_native.log"
    mpirun -np "${nprocs}" --hostfile hostfile perf_record.sh ${frequence} "${path}/${name}" | tee -a "${name}_native.log"
    date | tee -a "${name}_native.log"
    echo | tee -a "${name}_native.log"
    killall sar
  done
  
}


# run_bench(bench, class, nprocs, repetitions, path)
run_bench() {
  cp /proc/cpuinfo .
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local path="${5}"
  local nprocessors="${6}"
  local name="${bench}.${class}.${nprocs}"
  
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
    mpirun -np "${nprocs}" -mca plm_rsh_args "-o StrictHostKeyChecking=no" --oversubscribe --hostfile hostfile singularity exec $HOME/ubuntu.img "${path}${name}" | tee -a "${name}_singularity.log"
    date | tee -a "${name}_singularity.log"
    echo | tee -a "${name}_singularity.log"
  done

}




# for class in "${CLASSES[@]}"
# Bash starts from ZERO
for (( i=0; i<=4; i++ )); do
  for bench in "${BENCHS[@]}"; do
    echo "Runing ${bench} ${CLASSES[$i]} $NUM_PROC at ${FREQUENCES[$i]}"
    run_bench_stats ${bench} "${CLASSES[$i]}" $NUM_PROC ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES} "${FREQUENCES[$i]}"
  done
done


class = "A"
bench = "cg"
echo "Runing ${bench} ${class} $NUM_PROC"
run_bench ${bench} "${class}" $NUM_PROC ${NUMBER_REPETITIONS} ${BIN_PATH} ${TOTAL_CORES}
