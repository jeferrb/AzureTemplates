#!/bin/bash

exit

declare -a AZURE_MACHINES=( 61 107 142 67 113 143 46 99 144 116 )
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


# -----------   Experiments  -------------
61	"Standard_D4s_v3",				"4",			"16384"
107	"Standard_E4s_v3",				"4",			"32768"
142	"Standard_F4s_v2",				"4",			"8000"

67	"Standard_D8s_v3",				"8",			"32768"
113	"Standard_E8s_v3",				"8",			"65536"
143	"Standard_F8s_v2",				"8",			"16000"

46	"Standard_D16s_v3",				"16",			"65536"
99	"Standard_E16s_v3",				"16",			"131072"
144	"Standard_F16s_v2",				"16",			"32000"
116	"Standard_F16s",				"16",			"32768"

#  ________________________
