#!/bin/bash

# Esta versao sera usada para o teste de escalabilidade
#  O numero de maquinas crescera conforme os experimentos forem sendo executados
#  Este script deve possuir a capacidade de criar um numero X de maquinas e configuralas.
#  Depois, com outro argumento, disparar os experimentos nelas.
#  Por fim ele deve matar o grupo
# Ele recebe como argumento o nome do GROUP_NAME e o segundo argumento sera:
#   1 - para criar uma maquina, sendo o terceiro argumento o tipo da maquina, o quarto o numero de maquinas
#   2 - para disparar os experimentos, sendo o terceiro argumento o nome do script, o quarto argumento o numero de jobs a executar e a sequencia tuplas de:
#       [#maquinas com #slots]  (maximo dois tipos) - para compor o hostfile que deve ser enviado para todas as maquinas
#   3 - para recuperar os resultados e destruir o grupo
# E chamado pelo run_scalability_test.py

set -x
# cd $HOME/AzureTemplates
GROUP_NAME=${1}
NEW_BIN_PATH="$HOME/bin"
NUMBER_REPETITIONS=1
REGION="East US"

declare -a VM_SIZES=("Basic_A0" "Basic_A1" "Basic_A2" "Basic_A3" "Basic_A4" "Standard_A0" "Standard_A1" "Standard_A1_v2" "Standard_A10" "Standard_A11" "Standard_A2" "Standard_A2_v2" "Standard_A2m_v2" "Standard_A3" "Standard_A4" "Standard_A4_v2" "Standard_A4m_v2" "Standard_A5" "Standard_A6" "Standard_A7" "Standard_A8" "Standard_A8_v2" "Standard_A8m_v2" "Standard_A9" "Standard_B1ms" "Standard_B1s" "Standard_B2ms" "Standard_B2s" "Standard_B4ms" "Standard_B8ms" "Standard_D1" "Standard_D1_v2" "Standard_D11" "Standard_D11_v2" "Standard_D11_v2_Promo" "Standard_D12" "Standard_D12_v2" "Standard_D12_v2_Promo" "Standard_D13" "Standard_D13_v2" "Standard_D13_v2_Promo" "Standard_D14" "Standard_D14_v2" "Standard_D14_v2_Promo" "Standard_D15_v2" "Standard_D16_v3" "Standard_D16s_v3" "Standard_D2" "Standard_D2_v2" "Standard_D2_v2_Promo" "Standard_D2_v3" "Standard_D2s_v3" "Standard_D3" "Standard_D3_v2" "Standard_D3_v2_Promo" "Standard_D32_v3" "Standard_D32s_v3" "Standard_D4" "Standard_D4_v2" "Standard_D4_v2_Promo" "Standard_D4_v3" "Standard_D4s_v3" "Standard_D5_v2" "Standard_D5_v2_Promo" "Standard_D64_v3" "Standard_D64s_v3" "Standard_D8_v3" "Standard_D8s_v3" "Standard_DS1" "Standard_DS1_v2" "Standard_DS11" "Standard_DS11_v2" "Standard_DS11_v2_Promo" "Standard_DS12" "Standard_DS12_v2" "Standard_DS12_v2_Promo" "Standard_DS13" "Standard_DS13_v2" "Standard_DS13_v2_Promo" "Standard_DS13-2_v2" "Standard_DS13-4_v2" "Standard_DS14" "Standard_DS14_v2" "Standard_DS14_v2_Promo" "Standard_DS14-4_v2" "Standard_DS14-8_v2" "Standard_DS15_v2" "Standard_DS2" "Standard_DS2_v2" "Standard_DS2_v2_Promo" "Standard_DS3" "Standard_DS3_v2" "Standard_DS3_v2_Promo" "Standard_DS4" "Standard_DS4_v2" "Standard_DS4_v2_Promo" "Standard_DS5_v2" "Standard_DS5_v2_Promo" "Standard_E16_v3" "Standard_E16s_v3" "Standard_E2_v3" "Standard_E2s_v3" "Standard_E32_v3" "Standard_E32-16s_v3" "Standard_E32-8s_v3" "Standard_E32s_v3" "Standard_E4_v3" "Standard_E4s_v3" "Standard_E64_v3" "Standard_E64-16s_v3" "Standard_E64-32s_v3" "Standard_E64s_v3" "Standard_E8_v3" "Standard_E8s_v3" "Standard_F1" "Standard_F16" "Standard_F16s" "Standard_F1s" "Standard_F2" "Standard_F2s" "Standard_F4" "Standard_F4s" "Standard_F8" "Standard_F8s" "Standard_H16" "Standard_H16m" "Standard_H16mr" "Standard_H16r" "Standard_H8" "Standard_H8m" "Standard_NC12" "Standard_NC12s_v2" "Standard_NC24" "Standard_NC24r" "Standard_NC24rs_v2" "Standard_NC24s_v2" "Standard_NC6" "Standard_NC6s_v2" "Standard_NV12" "Standard_NV24" "Standard_NV6" "Standard_F2s_v2" "Standard_F4s_v2" "Standard_F8s_v2" "Standard_F16s_v2" "Standard_F32s_v2" "Standard_F64s_v2" "Standard_F72s_v2")
declare -a VM_CORES=("1" "1" "2" "4" "8" "1" "1" "1" "8" "16" "2" "2" "2" "4" "8" "4" "4" "2" "4" "8" "8" "8" "8" "16" "1" "1" "2" "2" "4" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "20" "16" "16" "2" "2" "2" "2" "2" "4" "4" "4" "32" "32" "8" "8" "8" "4" "4" "16" "16" "64" "64" "8" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "8" "8" "16" "16" "16" "16" "16" "20" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "16" "2" "2" "32" "32" "32" "32" "4" "4" "64" "64" "64" "64" "8" "8" "1" "16" "16" "1" "2" "2" "4" "4" "8" "8" "16" "16" "16" "16" "8" "8" "12" "12" "24" "24" "24" "24" "6" "6" "12" "24" "6" "2" "4" "8" "16" "32" "64" "72")


MOUNTPOINT=$HOME/mymountpoint
RESULTS_DIRECTORY="$MOUNTPOINT/results_${GROUP_NAME}/result"
LOG_FILE="${RESULTS_DIRECTORY}/logfile_${GROUP_NAME}.log"
PASSWORD="pass${RANDOM}lala"
DISK_PASSWORD="gGEn7CeoUxlkf/EY6sUlrZFg4ebJw3ZkjJ0QvZ5viW0ES+bRDllVwLQy17M9PcWaM4PoRGhqycd9BFE7OadAqg=="
COORDINATOR_KEY=${RESULTS_DIRECTORY}/id_rsa_coodinator_${GROUP_NAME}.pub
COORDINATOR_PROF=${RESULTS_DIRECTORY}/coordinator.profile
# IMAGE_REFERENCE="/subscriptions/6878f6a8-b14a-4455-a1c1-655f5f5fac2d/resourceGroups/image-2/providers/Microsoft.Compute/images/perf-image" # singularity (original) (MPI GPU 2)
IMAGE_REFERENCE="/subscriptions/054e3a7f-c270-4673-ae8d-bbeae92058d7/resourceGroups/toy2dac_image/providers/Microsoft.Compute/images/Toy2Dac-image-20190405111950" # Will-toy2dac (Container Exploration)
USERNAME="ubuntu"
EXECUTION_PATH="~/"
# EXECUTION_SCRIPT="./scripts/run_bench_dimensioned.sh"
NUMBER_CREATION_ATTEMPTS=10

mkdir -p ${RESULTS_DIRECTORY}

# cmd= azure_machines + number_instances + '2>&1 | tee -a ${RESULTS_DIRECTORY}.log.txt &'

createMachines(){
    echo "Creating the machine number $1"
    az group deployment create --name "SingularityTest$(whoami)$(date +%s)" \
    --resource-group $GROUP_NAME \
    --template-file azuredeploy_from_generic_image.json \
    --parameters vmSize=$2 vmName="testMPI${1}" dnsLabelPrefix="prefix${RANDOM}${1}" \
    adminPassword=$PASSWORD scriptParameterPassMount=$PASSWORD imageReference=$IMAGE_REFERENCE \
    adminPublicKey="`cat ~/.ssh/id_rsa.pub`" adminUsername=$USERNAME |& tee -a ${LOG_FILE}
}

retrieveResults(){ # It is not needed anymore
    for ssh_addr in `grep "ssh " ${LOG_FILE} | cut -d '@' -f 2 | rev | cut -c 2- | rev`; do
        scp "${ssh_addr}:/home/${USERNAME}/*.log" ${RESULTS_DIRECTORY} &
    done
    wait
}

# The second argument determines script action
case ${2} in
    'create')
        VM_SIZE=${VM_SIZES[${3}]}
        NUMBER_EXPECTED_INSTANCES=${4}
        BIN_PATH="${5}" # TODO jeferson
        # NUMBER_INITIAL_INSTANCES=`grep "ssh " ${LOG_FILE} | wc -l | awk '{print $1}'`
        echo "Let's ${2} $NUMBER_EXPECTED_INSTANCES $VM_SIZE at $GROUP_NAME group"
        if [ ! -f ${LOG_FILE} ]; then
            echo "This group does not exists yeat, let's create it now"
            date > ${LOG_FILE}
            echo "Creating group ${GROUP_NAME}"
            az group create --name $GROUP_NAME --location "${REGION}"
            if [ ! $? -eq 0 ]; then
                echo "Faile to create group ${GROUP_NAME} exiting"
                exit
            fi
        fi

        remaining_creation_attempts=$NUMBER_CREATION_ATTEMPTS
        current_machines=`grep "ssh " ${LOG_FILE} | wc -l | awk '{print $1}'`
        while [[ $current_machines -ne $NUMBER_EXPECTED_INSTANCES && remaining_creation_attempts -gt 0 ]]; do
            for (( machine_number = current_machines; machine_number < $((current_machines + NUMBER_EXPECTED_INSTANCES)) ; machine_number++ )); do
                createMachines $machine_number ${VM_SIZE} &
                sleep 10
            done
            wait
            current_machines=`grep "ssh " ${LOG_FILE} | wc -l | awk '{print $1}'`
            remaining_creation_attempts=$((remaining_creation_attempts-1))
            echo NUMBER_EXPECTED_INSTANCES $NUMBER_EXPECTED_INSTANCES
            echo current_machines $current_machines
            echo remaining_creation_attempts $remaining_creation_attempts
        done

        # wait while to create the least machine
        sleep 5

        # Add access credential for all virtual machines and copy the binary files to each machine
        for i in `grep "ssh " ${LOG_FILE} | cut -d '@' -f 2 | rev | cut -c 2- | rev`; do
            echo " Copy id from $i"
            ssh-keygen -R $i
            ssh-keygen -R `dig +short $i`
            ssh-keyscan -H $i >> ~/.ssh/known_hosts
            ssh ${USERNAME}@${i} << EOF
                cp -r ${BIN_PATH} ${NEW_BIN_PATH}
                echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
EOF
        done

        # Get coordinator address (the first one)
        SSH_ADDR=`grep "ssh " ${LOG_FILE} | head -n 1 | cut -c 23- | rev | cut -c 2- | rev`
        if [[ -z "${SSH_ADDR}" ]]; then
            echo "Faile to create a VM instace, reverting changes"
            az group delete --resource-group ${GROUP_NAME} --yes --no-wait
        fi

        # If there is no coordinator key and profile, create one
        if [ ! -f $COORDINATOR_KEY ]; then
            # Create an id RSA for the coordenator
            ssh ${SSH_ADDR} << EOF
                set -x
                ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
EOF
            # retrieve coordinator (master) credential
            scp ${SSH_ADDR}:.ssh/id_rsa.pub $COORDINATOR_KEY
            scp ${SSH_ADDR}:.profile $COORDINATOR_PROF
            cat << EOF >> $COORDINATOR_PROF
source /opt/intel/compilers_and_libraries_2018.3.222/linux/bin/compilervars.sh -arch intel64 -platform linux
source /opt/intel/parallel_studio_xe_2018.3.051/bin/psxevars.sh

EOF
        fi

        # copy coordinator (master) credential to all slaves
        for i in `grep "ssh " ${LOG_FILE} | cut -d '@' -f 2 | rev | cut -c 2- | rev`; do
            echo "Put ssh key on $i"
            ssh-copy-id -f -i $COORDINATOR_KEY "${USERNAME}@${i}"
            scp $COORDINATOR_PROF "${USERNAME}@${i}:.profile"
        done

    ;;
    'execute')
    # TODO: colocar o tipo das instancias no logfile
    # VM_SIZE=`grep "vmSize" ${LOG_FILE} -A2 | tail -n1 | awk '{print $2}' | sed 's/\"//g'`

        EXECUTION_SCRIPT="${3}"
        NUMBER_JOBS="${4}"
        echo "Let's ${2} $NUMBER_JOBS jobs at $GROUP_NAME group"
        NUMBER_CURRENT_INSTANCES=`grep "ssh " ${LOG_FILE} | wc -l | awk '{print $1}'`

        # create a custom hostfile to divide the jobs along machines
        rm -f ${RESULTS_DIRECTORY}/hostfile
        rm -f ${RESULTS_DIRECTORY}/machines
        host=4 # starts with 4, the fisrt IP of subnet
        num_machines_arg=5 # the number of machines is the fourth+1 (sixth+1, eighth+1, ...) argument
        while [[ -n "${!num_machines_arg}" ]]; do
            num_slots_arg=$((num_machines_arg+1))
            for (( i = 0; i < "${!num_machines_arg}"; i++ )); do
                echo "10.0.0.${host} slots=${!num_slots_arg}" >> ${RESULTS_DIRECTORY}/hostfile
                echo "10.0.0.${host}:${!num_slots_arg}" >> ${RESULTS_DIRECTORY}/machines
                host=$((host+1))
            done
            num_machines_arg=$((num_machines_arg+2))
        done

        NUMBER_EXPECTED_INSTANCES=`wc -l ${RESULTS_DIRECTORY}/hostfile | awk '{print $1}'`

        if [[ NUMBER_EXPECTED_INSTANCES -gt NUMBER_CURRENT_INSTANCES ]]; then
            echo "Number of requested slots ($NUMBER_EXPECTED_INSTANCES) are greater than created instances ($NUMBER_CURRENT_INSTANCES)"
            echo "Exiting..."
            exit
        fi

        # Get coordinator address (the first one)
        SSH_ADDR=`grep "ssh " ${LOG_FILE} | head -n 1 | cut -c 23- | rev | cut -c 2- | rev`

        # Push the scripts and hostfile to coordinator
        scp ${RESULTS_DIRECTORY}/hostfile ${RESULTS_DIRECTORY}/machines ${SSH_ADDR}:
        scp ${EXECUTION_SCRIPT} ${SSH_ADDR}:

        ssh ${SSH_ADDR} << EOF
            set -x
            # Add all nodes to known hosts and copy the private key to all machines
            rm ~/.ssh/known_hosts
            for host in \`seq 4 $((${NUMBER_CURRENT_INSTANCES}+3))\`; do
                ssh-keyscan -H "10.0.0.\${host}" >> ~/.ssh/known_hosts
                scp .ssh/id_rsa .ssh/id_rsa.pub "10.0.0.\${host}":.ssh
                scp -r  ~/mymountpoint/toy2dac_instrumented/marmousi_template_modeled "10.0.0.\${host}":execute_marmousi_template
                scp -r  ~/mymountpoint/toy2dac_instrumented/run_marmousi_template_original_modeled/ "10.0.0.\${host}":execute_marmousi_template_original
                scp -r  ~/mymountpoint/toy2dac_instrumented/run_ball_template_modeled/ "10.0.0.\${host}":execute_ball_template
                scp -r  ~/mymountpoint/toy2dac "10.0.0.\${host}":
            # Copy the execution script to all machines
                scp ${EXECUTION_SCRIPT##*/} "10.0.0.\${host}":
            done
            # Copy known host that contains all machines to all machines
            for host in \`seq 4 $((${NUMBER_CURRENT_INSTANCES}+3))\`; do
                scp .ssh/known_hosts "10.0.0.\${host}":.ssh
            done
EOF
        # Effectively execute the benchmark
        echo bash ~/${EXECUTION_SCRIPT##*/} ${NUMBER_REPETITIONS} ${NEW_BIN_PATH} ${NUMBER_JOBS} ${RESULTS_DIRECTORY}

        ssh ${SSH_ADDR} << EOF
            set -x
            for i in execute_marmousi_template execute_marmousi_template_original execute_ball_template; do
                bash --login -c 'cd $i ; bash ~/${EXECUTION_SCRIPT##*/} ${NUMBER_REPETITIONS} ${NEW_BIN_PATH} ${NUMBER_JOBS} ${RESULTS_DIRECTORY}'
            done
EOF

    ;;
    'destroy')
        echo "Let's ${2} the $GROUP_NAME group"
        az group delete --yes --no-wait --resource-group ${GROUP_NAME}
    ;;
esac
