#!/bin/bash

# nohup bash -c "(time ./run_all.sh) &> mountpoint/results/nohup_output.log" &
set -x
for i in `seq 0 1`; do
./scripts/run_mpi_benchmark.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${i}
done
if [ -d "~/mountpoint/results" ]; then
  cp -r *result* 
fi
