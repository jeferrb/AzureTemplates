#!/bin/bash

LOGFILE="/home/username/instalation.log"

sleep 15

#check network conction
ATTEMPTS=0
while [ $(nc -zw1 google.com 443) ] && [ "$ATTEMPTS" -lt 5 ]; do
  echo "we have NO connectivity" &>> ${LOGFILE}
  sleep 15
  ATTEMPTS=$((ATTEMPTS+1))
done

echo "Connected before $ATTEMPTS attempts" &>> ${LOGFILE}

if [[ $SWAP ]]; then
	#Create a swapfile
	sudo fallocate -l 4G /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	sudo bash -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
fi

# creade and setup the shared folder 
sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

echo cp "/home/username/mymountpoint/ubuntu.img /home/username/" &>> ${LOGFILE}
cp /home/username/mymountpoint/ubuntu.img /home/username/  &>> ${LOGFILE} &

sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo sed -ir 's/5-55\/10/\*\/2/g' /etc/cron.d/sysstat
sudo service sysstat restart


#Install MPI and dependencies
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y update
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc &>> ${LOGFILE} &
# sudo apt-get install -y openmpi-bin libopenmpi-dev libhdf5-openmpi-dev &>> ${LOGFILE} &

# Install Singularity
echo "*************** Install Singularity" &>> ${LOGFILE}
VERSION=2.4.2
cd /home/username/mymountpoint/singularity-$VERSION
sudo make install | tee -a ${LOGFILE}


#enable Perf
sudo sh -c 'echo -1 >/proc/sys/kernel/perf_event_paranoid'
sudo sh -c 'echo 0 > /proc/sys/kernel/kptr_restrict'

sudo sh -c 'echo kernel.perf_event_paranoid=-1 >> /etc/sysctl.d/local.conf'
sudo sh -c 'echo kernel.kptr_restrict=0 >> /etc/sysctl.d/local.conf'

wait

echo "done" > /home/username/donefile.txt

# cp /home/username/mymountpoint/ubuntu.img /home/username/

# singularity pull shub://ruycastilho/GPUtest:1604
