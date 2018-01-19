# run_bench(bench, class, nprocs, repetitions, hosts)
function run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local hosts="${5}"
  local name="${bench}.${class}.${nprocs}"
  
  nohup sar -o "${name}.sa" 5 > /dev/null 2>&1 &
  
  for i in `seq ${repetitions}`; do
    echo "Running ${name} (${i}/${repetitions})" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    mpirun -np "${nprocs}"  -host "${hosts}" "${BIN_PATH}${name}" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    echo | tee -a "${name}.log"
  done
  
  killall sar
}