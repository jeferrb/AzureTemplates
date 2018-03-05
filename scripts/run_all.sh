#!/bin/bash

exit

declare -a AZURE_MACHINES=( 1 2 3 4 9 55 )
declare -a NUMBER_INSTANCES=( 1 2 4 8 16 32 )


# set -x
for i in `seq ${#AZURE_MACHINES[@]} -1 1`; do
	for j in `seq 1 \` echo ${#AZURE_MACHINES[@]}-$i+1 | bc \``; do
		echo "AZURE_MACHINES: ${AZURE_MACHINES[$i]}"
		echo "NUMBER_INSTANCES: ${NUMBER_INSTANCES[$j]}"
		# ./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES[$i]} ${NUMBER_INSTANCES[$j]} 2>&1 | tee -a results/run_mpi_benchmark_v5_${i}_${j}.log &
		# sleep 3
	done
done


AZURE_MACHINES=55
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=9
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=4
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=3
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &


AZURE_MACHINES=9
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=4
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

AZURE_MACHINES=3
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=2
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

# wait

AZURE_MACHINES=4
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=3
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

# ------------------------


AZURE_MACHINES=2
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=1
NUMBER_INSTANCES=8
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &


AZURE_MACHINES=3
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=2
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=1
NUMBER_INSTANCES=4
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &


AZURE_MACHINES=2
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=1
NUMBER_INSTANCES=2
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &


AZURE_MACHINES=1
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &


# ------------------------


AZURE_MACHINES=1
NUMBER_INSTANCES=16
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=2
NUMBER_INSTANCES=16
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

AZURE_MACHINES=1
NUMBER_INSTANCES=32
./scripts/run_mpi_benchmark_v5.sh Senha123 gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &

