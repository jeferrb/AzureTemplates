#!/bin/bash

declare -a AZURE_MACHINES=( 1 2 3 4 9 55 )
declare -a NUMBER_INSTANCES=( 1 2 4 8 16 32 )

if [[ 0 ]]; then

AZURE_MACHINES=55
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=9
NUMBER_INSTANCES=2
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=4
NUMBER_INSTANCES=4
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=3
NUMBER_INSTANCES=8
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


AZURE_MACHINES=9
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=4
NUMBER_INSTANCES=2
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

AZURE_MACHINES=3
NUMBER_INSTANCES=4
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=2
NUMBER_INSTANCES=8
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


AZURE_MACHINES=4
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=3
NUMBER_INSTANCES=2
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

# ------------------------

AZURE_MACHINES=2
NUMBER_INSTANCES=4
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=1
NUMBER_INSTANCES=8
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


AZURE_MACHINES=3
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=2
NUMBER_INSTANCES=2
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=1
NUMBER_INSTANCES=4
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


AZURE_MACHINES=2
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &

AZURE_MACHINES=1
NUMBER_INSTANCES=2
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


AZURE_MACHINES=1
NUMBER_INSTANCES=1
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log &


# **************************


AZURE_MACHINES=1
NUMBER_INSTANCES=16
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log

AZURE_MACHINES=2
NUMBER_INSTANCES=16
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log

AZURE_MACHINES=1
NUMBER_INSTANCES=32
./scripts/run_opm_benchmark.sh gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a results/run_mpi_benchmark_v3_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log

fi
