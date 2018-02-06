#!/bin/bash

# the first paramiter is the admin password, the second one is the Mout disk password the tird one is the vmSize the forth is the number of instances

set -x
GROUP_NAME=mpi${RANDOM}
NUMBER_INSTANCES=${4}
BIN_PATH="/home/username/mymountpoint/NPB3.3-MPI/bin/"
NUMBER_REPETITIONS=3
declare -a VM_SIZES=("Basic_A0" "Basic_A1" "Basic_A2" "Basic_A3" "Basic_A4" "Standard_A0" "Standard_A1" "Standard_A1_v2" "Standard_A10" "Standard_A11" "Standard_A2" "Standard_A2_v2" "Standard_A2m_v2" "Standard_A3" "Standard_A4" "Standard_A4_v2" "Standard_A4m_v2" "Standard_A5" "Standard_A6" "Standard_A7" "Standard_A8" "Standard_A8_v2" "Standard_A8m_v2" "Standard_A9" "Standard_B1ms" "Standard_B1s" "Standard_B2ms" "Standard_B2s" "Standard_B4ms" "Standard_B8ms" "Standard_D1" "Standard_D1_v2" "Standard_D11" "Standard_D11_v2" "Standard_D11_v2_Promo" "Standard_D12" "Standard_D12_v2" "Standard_D12_v2_Promo" "Standard_D13" "Standard_D13_v2" "Standard_D13_v2_Promo" "Standard_D14" "Standard_D14_v2" "Standard_D14_v2_Promo" "Standard_D15_v2" "Standard_D16_v3" "Standard_D16s_v3" "Standard_D2" "Standard_D2_v2" "Standard_D2_v2_Promo" "Standard_D2_v3" "Standard_D2s_v3" "Standard_D3" "Standard_D3_v2" "Standard_D3_v2_Promo" "Standard_D32_v3" "Standard_D32s_v3" "Standard_D4" "Standard_D4_v2" "Standard_D4_v2_Promo" "Standard_D4_v3" "Standard_D4s_v3" "Standard_D5_v2" "Standard_D5_v2_Promo" "Standard_D64_v3" "Standard_D64s_v3" "Standard_D8_v3" "Standard_D8s_v3" "Standard_DS1" "Standard_DS1_v2" "Standard_DS11" "Standard_DS11_v2" "Standard_DS11_v2_Promo" "Standard_DS12" "Standard_DS12_v2" "Standard_DS12_v2_Promo" "Standard_DS13" "Standard_DS13_v2" "Standard_DS13_v2_Promo" "Standard_DS13-2_v2" "Standard_DS13-4_v2" "Standard_DS14" "Standard_DS14_v2" "Standard_DS14_v2_Promo" "Standard_DS14-4_v2" "Standard_DS14-8_v2" "Standard_DS15_v2" "Standard_DS2" "Standard_DS2_v2" "Standard_DS2_v2_Promo" "Standard_DS3" "Standard_DS3_v2" "Standard_DS3_v2_Promo" "Standard_DS4" "Standard_DS4_v2" "Standard_DS4_v2_Promo" "Standard_DS5_v2" "Standard_DS5_v2_Promo" "Standard_E16_v3" "Standard_E16s_v3" "Standard_E2_v3" "Standard_E2s_v3" "Standard_E32_v3" "Standard_E32-16s_v3" "Standard_E32-8s_v3" "Standard_E32s_v3" "Standard_E4_v3" "Standard_E4s_v3" "Standard_E64_v3" "Standard_E64-16s_v3" "Standard_E64-32s_v3" "Standard_E64s_v3" "Standard_E8_v3" "Standard_E8s_v3" "Standard_F1" "Standard_F16" "Standard_F16s" "Standard_F1s" "Standard_F2" "Standard_F2s" "Standard_F4" "Standard_F4s" "Standard_F8" "Standard_F8s" "Standard_H16" "Standard_H16m" "Standard_H16mr" "Standard_H16r" "Standard_H8" "Standard_H8m" "Standard_NC12" "Standard_NC12s_v2" "Standard_NC24" "Standard_NC24r" "Standard_NC24rs_v2" "Standard_NC24s_v2" "Standard_NC6" "Standard_NC6s_v2" "Standard_NV12" "Standard_NV24" "Standard_NV6")
declare -a VM_CORES=("1" "1" "2" "4" "8" "1" "1" "1" "8" "16" "2" "2" "2" "4" "8" "4" "4" "2" "4" "8" "8" "8" "8" "16" "1" "1" "2" "2" "4" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "20" "16" "16" "2" "2" "2" "2" "2" "4" "4" "4" "32" "32" "8" "8" "8" "4" "4" "16" "16" "64" "64" "8" "8" "1" "1" "2" "2" "2" "4" "4" "4" "8" "8" "8" "8" "8" "16" "16" "16" "16" "16" "20" "2" "2" "2" "4" "4" "4" "8" "8" "8" "16" "16" "16" "16" "2" "2" "32" "32" "32" "32" "4" "4" "64" "64" "64" "64" "8" "8" "1" "16" "16" "1" "2" "2" "4" "4" "8" "8" "16" "16" "16" "16" "8" "8" "12" "12" "24" "24" "24" "24" "6" "6" "12" "24" "6")
VM_SIZE=${VM_SIZES[${3}]}
NUMBER_RROCESSORS=${VM_CORES[${3}]}
NUMBER_JOBS=`echo "${NUMBER_INSTANCES} * ${NUMBER_RROCESSORS}" | bc`
RESULTS_DIRECTORY="results/${VM_SIZE}_instances_${NUMBER_INSTANCES}_result"
LOG_DIR=${VM_SIZE}_${NUMBER_INSTANCES}_${NUMBER_REPETITIONS}_${GROUP_NAME}
LOG_FILE=${LOG_DIR}/logfile_${VM_SIZE}_${NUMBER_INSTANCES}_${GROUP_NAME}.log

MINWAIT=120
MAXWAIT=200
MAXWAIT=`echo "$MAXWAIT-$MINWAIT" | bc`

lockfile=/tmp/myCreateAzureMachine.lock

function pause(){
    read -p "$*"
    # echo "$*"
}

createMachines(){
    echo "Creating the machine number $1"
  while [[ -e  $lockfile ]]; do
    sleep $((RANDOM % 200))
  done
  touch "$lockfile"
    # az group deployment create --verbose --debug --name SingularityTest --resource-group $GROUP_NAME \
    # --template-uri "https://raw.githubusercontent.com/jeferrb/AzureTemplates/master/azuredeploy.json" \
    az group deployment create --name "SingularityTest$(whoami)$(date +%s)" --resource-group $GROUP_NAME \
    --template-file azuredeploy_multiple_from_new_image.json --parameters vmSize="${VM_SIZE}" vmName="testMpi${1}" dnsLabelPrefix="my${GROUP_NAME}dnsprefix${1}" \
    adminPassword=$2 scriptParameterPassMount=$3 adminPublicKey="`cat ~/.ssh/id_rsa.pub`" > ${LOG_FILE}_${1}.log
    local SSH_ADDR=`grep "ssh " ${LOG_FILE}_${1}.log | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
    local HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
  rm -r "$lockfile"
    sleep $(((RANDOM % $MAXWAIT)+$MINWAIT))
    # Add all credential do cop the host public key later
    ssh-keygen -R ${HOST_ADDR}
    ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts

    echo "" > known_hosts
    scp known_hosts ${HOST_ADDR}:.ssh/known_hosts
ssh ${SSH_ADDR} << EOF
rm -f *.log
rm  ~/.ssh/known_hosts
EOF
    cat ${LOG_FILE}_${1}.log >> ${LOG_FILE}
    # rm ${LOG_FILE}_${1}.log
    # echo "${HOST_ADDR} slots=${NUMBER_RROCESSORS}" >> ${LOG_DIR}/hostfile
}


mkdir -p ${LOG_DIR}

date > ${LOG_FILE}
echo "Creating group ${GROUP_NAME}"
az group create --name $GROUP_NAME --location "South Central US"
if [ ! $? -eq 0 ]; then
    echo "Faile to create group ${GROUP_NAME} exiting"
    exit
fi

# FILE=~/.ssh/id_rsa.pub
# if [ ! -e "$FILE" ]; then
#     # if there is not an rsa key, create it
#     echo "File $FILE does not exist"
#     ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
# fi

# rm ${LOG_DIR}/hostfile
for (( i = 1; i < $NUMBER_INSTANCES + 1 ; i++ )); do
    createMachines $i $1 $2 &
    sleep $(((RANDOM % 10)+3))
done
wait

# da uns 3 minutinho pras maquina ser criada
# sleep 180

echo "******************************************"  >> ${LOG_FILE}

# grep "ssh " ${LOG_FILE}
SSH_ADDR=`grep "ssh " ${LOG_FILE} | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
if [[ -z "${SSH_ADDR}" ]]; then
    echo "Faile to create a VM instace, reverting changes"
    az group delete --resource-group ${GROUP_NAME} --yes --no-wait
fi

# Create an id RSA for the coordenator # Do it just if the next scp fails
# ssh ${SSH_ADDR} << EOF
#     ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
#     FILE=~/.ssh/id_rsa.pub
#     if [ ! -e "\$FILE" ]; then
#         # if there is not an rsa key, create it
#         echo "File \$FILE does not exist"
#         ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
#     fi
# EOF

grep "ssh " ${LOG_FILE} | cut -d '@' -f 2 | rev | cut -c 2- | rev | xargs -L1 ssh-keygen -R
grep "ssh " ${LOG_FILE} | cut -d '@' -f 2 | rev | cut -c 2- | rev | xargs -L1 ssh-keyscan -H >> ~/.ssh/known_hosts
# copy coordinator (master) credential to all slaves
scp ${SSH_ADDR}:~/.ssh/id_rsa.pub ${LOG_DIR}/id_rsa_coodinator_${GROUP_NAME}.pub
grep "ssh " ${LOG_FILE} | xargs -L1 echo | cut -c 12- | xargs -L1 ssh-copy-id -f -i ${LOG_DIR}/id_rsa_coodinator_${GROUP_NAME}.pub
rm ${LOG_DIR}/id_rsa_coodinator_${GROUP_NAME}.pub
# pause "Press [Enter] key to execute"

# rm ${LOG_DIR}/hostfile
for host in `seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)`; do
    echo "10.0.0.${host} slots=${NUMBER_RROCESSORS}" >> ${LOG_DIR}/hostfile
done

scp scripts/run_bench.sh ${LOG_DIR}/hostfile ${SSH_ADDR}:
# rm ${LOG_DIR}/hostfile
ssh ${SSH_ADDR} << EOF
    set -x
    rm ~/.ssh/known_hosts
    # ssh-keygen -f "/home/username/.ssh/known_hosts" -R
    echo "" > known_hosts
    for host in \`seq 4 $(echo ${NUMBER_INSTANCES}+3 | bc)\`; do
        scp -o StrictHostKeyChecking=no known_hosts 10.0.0.${i}:.ssh/known_hosts
        # ssh-keygen -R "10.0.0.\${host}"
        # ssh-keyscan -H "10.0.0.\${host}" >> ~/.ssh/known_hostsscp -o StrictHostKeyChecking=no known_hosts 10.0.0.${i}:.ssh/known_hosts
        # ssh-keygen -R "my${GROUP_NAME}dnsprefix\${host}.southcentralus.cloudapp.azure.com"
        # ssh-keyscan -H "my${GROUP_NAME}dnsprefix\${host}.southcentralus.cloudapp.azure.com" >> ~/.ssh/known_hosts
    done
    chmod +x run_bench.sh
    ./run_bench.sh ${NUMBER_REPETITIONS} ${BIN_PATH} ${NUMBER_JOBS}
EOF
mkdir -p ${RESULTS_DIRECTORY}
scp "${SSH_ADDR}:/home/username/*.log" ${RESULTS_DIRECTORY}
scp "${SSH_ADDR}:/home/username/*.sa" ${RESULTS_DIRECTORY}

# pause "Press [Enter] key to delete the group ${GROUP_NAME}"
echo "To tedeleting the resource type:"
az group delete --resource-group ${GROUP_NAME} --yes --no-wait

MOUNTPOINT=~/mountpoint/
if [ -d "$MOUNTPOINT" ]; then
    cp -r results "$MOUNTPOINT/results_$(whoami)$(date +%s)"
fi
