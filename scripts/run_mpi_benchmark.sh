#!/bin/sh

# the first paramiter is the password

GROUP_NAME=mpi1
NUMBER_EXECUTIONS=3
BIN_PATH="./mymountpoint/NPB3.3-MPI/bin/"
NUMBER_REPETITIONS=5
# set -x

function pause(){
    read -p "$*"
}

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

echo "------------------------------------------"  >> file.log.old
cat file.log >> file.log.old
date > file.log
echo "Creating group ${GROUP_NAME}"
az group create --name $GROUP_NAME --location "South Central US"

for (( i = 1; i < $NUMBER_EXECUTIONS + 1 ; i++ )); do
    echo "Creating the machine number $i"
    # az group deployment create --verbose --debug --name SingularityTest --resource-group $GROUP_NAME \
    az group deployment create --name SingularityTest --resource-group $GROUP_NAME \
    --template-file azuredeploy.json --parameters vmSize="Standard_D2s_v3" vmName="testMpi${i}" dnsLabelPrefix="my${GROUP_NAME}dnsprefix${i}" \
    adminPassword=$1 scriptParameterPassMount=$2 adminPublicKey="`cat ~/.ssh/id_rsa.pub`" >> file.log
    SSH_ADDR=`grep "ssh " file.log | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
    HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
    # Add all credential do cop the host public key later
    ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts
    # scp ${SSH_ADDR} ~/.ssh/id_rsa.pub id_rsa${i}.pub
done

pause "Press [Enter] key to continue"


echo "******************************************"  >> file.log

# grep "ssh " file.log
SSH_ADDR=`grep "ssh " file.log | tail -n 1 | cut -c 23- | rev | cut -c 2- | rev`
# HOST_ADDR=`echo $SSH_ADDR | cut -d '@' -f 2`
# ssh-keyscan -H ${HOST_ADDR} >> ~/.ssh/known_hosts

# copy coordinator (master) credential to all slaves
ssh ${SSH_ADDR} << EOF
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
EOF
scp ${SSH_ADDR}:~/.ssh/id_rsa.pub id_rsa_host.pub
grep "ssh " file.log | xargs -L1 echo | cut -c 12- | xargs -L1 ssh-copy-id -f -i id_rsa_host.pub

pause "Press [Enter] key to execute"

scp scripts/run_bench.sh ${SSH_ADDR}:

SUBNET_HOSTS=`seq 3 $(echo ${NUMBER_EXECUTIONS}+3 | bc) | tr '\n'  " "  | sed 's/ /,10.0.0./g' | cut -c 3- | rev | cut -c 9-| rev`
ssh ${SSH_ADDR} << EOF
    source run_bench.sh
    for file in ./mymountpoint/NPB3.3-MPI/bin/*.D.*; do
        # mpirun -np ${NUMBER_EXECUTIONS} -host ${SUBNET_HOSTS} ./mymountpoint/NPB3.3-MPI/bin/sp.S.16 >> remote.log
        for class in A B C D; do
            run_bench lu "${class}" 32 ${NUMBER_REPETITIONS}
            run_bench sp "${class}" 25 ${NUMBER_REPETITIONS}
            run_bench sp "${class}" 36 ${NUMBER_REPETITIONS}
            run_bench bt "${class}" 25 ${NUMBER_REPETITIONS}
            run_bench bt "${class}" 36 ${NUMBER_REPETITIONS}
        done
    done
EOF
mkdir results
scp '${SSH_ADDR}:/home/username/*.log' results
# echo "=========================================="  >> results.log
# -------> cat remote.log >> results.log
# echo "=========================================="  >> results.log

pause "Press [Enter] key to delete the group ${GROUP_NAME}"
az group delete --resource-group ${GROUP_NAME} --yes --no-wait


###########
for (( i = 0; i < 0; i++ )); do
    # mpirun -np 20 singularity exec ./mpi_sample  mymountpoint/ubuntu.img
    # mpirun -np 5 -host 10.0.0.5, 10.0.0.4 ./mpi_sample

    # --template-uri "https://raw.githubusercontent.com/jeferrb/AzureTemplates/master/azuredeploy.json" \

    # ssh -o StrictHostKeyChecking=no username@hostname.com
    ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -o UserKnownHostsFile=/dev/null username@hostname.com

    ssh-keygen -R [hostname]
    ssh-keygen -R [ip_address]
    ssh-keygen -R [hostname],[ip_address]
    ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
    ssh-keyscan -H [ip_address] >> ~/.ssh/known_hosts
    ssh-keyscan -H [hostname] >> ~/.ssh/known_hosts

done
