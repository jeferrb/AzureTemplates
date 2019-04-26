#!/bin/bash

set -x

declare -a SCRIPT_NAME="scripts/run_bench_klp.py" #TODO
declare -a AZURE_MACHINES=(11 101 118 119 17 32 33 47 48 50) # 10 2 100 )
declare -a QTD_MACHINES=1

execute_bench(){
	local GROUP_NAME=$1
	local AZURE_MACHINES=$2
	local SCRIPT_NAME=$3
	echo "AZURE_MACHINES: ${AZURE_MACHINES}"
	echo "NUMBER_INSTANCES: 1"
	set -x
	./scripts/run_mpi_benchmark_v10_klp.sh $GROUP_NAME create ${AZURE_MACHINES} $QTD_MACHINES
	./scripts/run_mpi_benchmark_v10_klp.sh $GROUP_NAME execute $SCRIPT_NAME 1 1 1
	./scripts/run_mpi_benchmark_v10_klp.sh $GROUP_NAME destroy
	set +x
}

for machine_number in "${AZURE_MACHINES[@]}"; do
	declare -a GROUP_NAME=mygroup-klp-$(date +%d-%m-%Y)-machine-${machine_number}
	execute_bench $GROUP_NAME ${machine_number} $SCRIPT_NAME &
	sleep 30
done
wait
