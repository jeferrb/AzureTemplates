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



# -----------   intense  -------------



# -----------   Running  -------------




AZURE_MACHINES=98
# cores "16"
NUMBER_INSTANCES=4
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))



AZURE_MACHINES=45
# cores "16"
NUMBER_INSTANCES=4
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))
 

wait


AZURE_MACHINES=55
# cores "32"
NUMBER_INSTANCES=2
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))



AZURE_MACHINES=145
# cores "32"
NUMBER_INSTANCES=2
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &



MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))


wait


AZURE_MACHINES=146
# cores "64"
NUMBER_INSTANCES=1
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &

 

AZURE_MACHINES=144
# cores "16"
NUMBER_INSTANCES=4
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))

wait


AZURE_MACHINES=65
# cores "64"
NUMBER_INSTANCES=1
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &

 

AZURE_MACHINES=45
# cores "16"
NUMBER_INSTANCES=4
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))
 
wait

AZURE_MACHINES=55
# cores "32"
NUMBER_INSTANCES=2
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


AZURE_MACHINES=64
# cores "64"
NUMBER_INSTANCES=1
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &

wait

AZURE_MACHINES=102
# cores "32"
NUMBER_INSTANCES=2
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))
 


AZURE_MACHINES=108
# cores "64"
NUMBER_INSTANCES=1
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


wait


AZURE_MACHINES=116
# cores "16"
NUMBER_INSTANCES=4
MOUNTPOINT=$HOME/mymountpoint/
RESULTS_DIRECTORY="$MOUNTPOINT/results_$(date +%d-%m-%Y)/${AZURE_MACHINES}_instances_${NUMBER_INSTANCES}_date_$(date +%d-%m-%Y)_result"
mkdir -p ${RESULTS_DIRECTORY}
./scripts/run_mpi_benchmark_v8.sh "pass${RANDOM}lala" gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &


MINWAIT=3
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`
sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))


# -----------   Done  -------------
