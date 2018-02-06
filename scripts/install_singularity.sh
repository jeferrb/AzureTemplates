#!/bin/bash

VERSION=2.4

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y update
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev bc
# For mpich do: sudo apt-get install mpich libmpich-dev libhdf5-mpich-dev

# wget -q https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
# tar -zxf openmpi-3.0.0.tar.gz
# cd openmpi-3.0.0
# ./configure --with-device=ch3:ssm --prefix="/home/$USER/.openmpi"
# make -j2 && sudo make install
# cat <<EOT >> ~/.bashrc
# export PATH="$PATH:/home/$USER/.openmpi/bin"
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"
# EOT
# source ~/.bashrc


# wget http://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz
# tar -zxf mpich-3.2.1.tar.gz
# cd mpich-3.2.1
# ./configure --prefix=/usr/local/mpich2-1.0 >& configure.log
# make -j >& make.log
# sudo make install >& install.log
# cat <<EOT >> ~/.bashrc
# export PATH="$PATH:/usr/local/mpich2-1.0"
# EOT
# source ~/.bashrc

wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make -j
sudo make -j install
cd
sudo mkdir /home/username/mymountpoint
echo "${1}" > pass
sudo bash -c 'echo "//test1diag281.file.core.windows.net/shared-fs /home/username/mymountpoint cifs nofail,vers=3.0,username=test1diag281,password=`cat pass`,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
rm pass
sudo mount -a

# cp /home/username/mymountpoint/ubuntu.img /home/username/

# singularity pull shub://ruycastilho/GPUtest:1604

################
# for the host machine, install Azure CLI
if [[ 0 ]]; then
	# Install required dependencies
	sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev build-essential
	# Install the CLI with curl
	curl -L https://aka.ms/InstallAzureCli | bash
	# restart your shell
	exec -l $SHELL
	# clear your shell's command hash cache
	hash -r
fi




