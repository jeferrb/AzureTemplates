#!/bin/bash

sudo apt-get update
sudo apt-get install -y wget make gcc libgfortran3 tmux htop git sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev gfortran build-essential


wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
tar -zxf NPB3.3.1.tar.gz
cd NPB3.3.1/NPB3.3-MPI/

cp config/make.def.template config/make.def
cat config/make.def.template | sed "s/MPIF77 = f77/MPIF77 = mpif90/g" | sed "s/MPICC = cc/MPICC = mpicc/g" > config/make.def


cp config/suite.def.template config/suite.def
		# for np in 1 2 4 8; do
np=4
for bench in bt cg ep ft is lu mg sp; do
	for size in A B C; do
		echo "$bench    $size    $np" >> config/suite.def
	done
done

make suite

mpirun -n 1 bin/cg.S.1


echo "172.31.48.139 slots=2" > hostfile
echo "172.31.56.63 slots=2" >> hostfile

mpirun -np 4 --hostfile hostfile NPB3.3.1/NPB3.3-MPI/bin/cg.A.4


mpirun -np 4 --host <IP1>,<IP1>,<IP2>,<IP2> NPB3.3.1/NPB3.3-MPI/bin/cg.A.4



# CPM / CRS

# Obtencao dos dados
git clone https://github.com/hpg-cepetro/IPDPS-CRS-CMP-code.git
wget www.ic.unicamp.br/~edson/minicurso-hpc/simple-synthetic.su

# Definicao dos parametros
PARAM_D="1" # Open CL Device
PARAM_V="4" # Verbose
PARAM_DATA=`realpath ~/simple-synthetic.su`
PARAM_A0="-0.7e-3"
PARAM_A1="0.7e-3"
PARAM_B0="-1e-7"
PARAM_B1="1e-7"
PARAM_C0="1.98e-7"
PARAM_C1="11.77e-6"
PARAM_NA="5"
PARAM_NB="5"
PARAM_NC_CMP="5000"
PARAM_NC_CRS="15"
PARAM_APH="600"
PARAM_APM="50"
PARAM_TAU="0.002"
PARAM_NGEN="30"
PARAM_AZIMUTH="0"

# CMP-CUDA
cd ~/IPDPS-CRS-CMP-code/CMP/CUDA/
mkdir bin
make
mkdir results
cd results
time ( ../bin/cmp-cuda \
	  -aph ${PARAM_APH} \
	  -c0 ${PARAM_C0} \
	  -c1 ${PARAM_C1} \
	  -nc ${PARAM_NC_CMP} \
	  -tau ${PARAM_TAU} \
	  -v ${PARAM_V} \
	  -i $PARAM_DATA )

# CMP-OpenCL
cd ~/IPDPS-CRS-CMP-code/CMP/OpenCL/
mkdir bin
cd bin
cmake ../
make -j
mkdir ../results
cd ../results
time ( ../bin/cmp-ocl2 \
	  -aph ${PARAM_APH} \
	  -c0 ${PARAM_C0} \
	  -c1 ${PARAM_C1} \
	  -nc ${PARAM_NC_CMP} \
	  -tau ${PARAM_TAU} \
	  -v ${PARAM_V} \
	  -i $PARAM_DATA )


# CRS-CUDA
cd ~/IPDPS-CRS-CMP-code/CRS/CUDA/
mkdir bin
make
mkdir results
cd results
time ( ../bin/crs-cuda \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-na ${PARAM_NA} \
	-nb ${PARAM_NB} \
	-nc ${PARAM_NC_CRS} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $PARAM_DATA )

# CRS-OpenCL
cd ~/IPDPS-CRS-CMP-code/CRS/OpenCL/
mkdir bin
cd bin
cmake ../
make -j
mkdir ../results
cd ../results
time ( ../bin/crs-ocl2 \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-na ${PARAM_NA} \
	-nb ${PARAM_NB} \
	-nc ${PARAM_NC_CRS} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $PARAM_DATA )


# CMP-OpenMP
cd ~/IPDPS-CRS-CMP-code/CMP/OpenMP/
mkdir bin
cd bin
cmake ../
make -j
mkdir ../results
cd ../results
time ../bin/cmp-omp2 -aph 600 -c0 1.98e-7 -c1 1.77e-6 -i ~/simple-synthetic.su -nc 15 -tau 0.002 -v 3


AWS_MACHINE="ec2-54-236-241-189.compute-1.amazonaws.com"
AWS_USERNAME="ubuntu"

cat ~/.ssh/id_rsa.pub | ssh -i "jeff_temp_key.pem" ${AWS_USERNAME}@${AWS_MACHINE} 'cat >> .ssh/authorized_keys && echo "Key copied"'
scp -r ssh_aws_nas_machines/* ${AWS_USERNAME}@${AWS_MACHINE}:.ssh
ssh-copy-id -f -i ssh_aws_nas_machines/id_rsa ${AWS_USERNAME}@${AWS_MACHINE}
ssh ${AWS_USERNAME}@${AWS_MACHINE} ""
