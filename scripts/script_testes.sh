#!/bin/bash


# export LD_LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:$LD_LIBRARY_PATH
# export ACC_DEVICE_TYPE=host

# singularity pull docker://nvidia/opencl
# set -x
# SIMPLE_SINTETIC=1
FOLD1000=1
#image from nvidia's dockerhub
IMAGE_PATH="$HOME/opencl.img"
# IMAGE_PATH="$HOME/ruycastilho-GPUtest-master.simg"
ROOT_DIR="$HOME/OpenCL-seismic-processing-tiago"

REPETITIONS=10

OPENACC=
OPENMP=

declare -a DIRECTORIES=("CMP/CUDA" "CMP/CUDAfp16" "CMP/OpenACC") # "CMP/OpenMP")
declare -a NAMES=("CMP-CUDA" "CMP-CUDAfp16" "CMP-OpenACC") # "CMP-OpenMP")
declare -a EXECUTABLES=("cmp-cuda" "cmp-cudafp16" "cmp-acc") # "cmp-omp2")

declare -a TYPES=("host" "singularity")

PARAM_D="1" # Open CL Device
PARAM_V="4" # Verbose

if [[ $JEQUITINHONHA -eq 1 ]]; then
DATASET="$HOME/Data/701-jequit-Data-Mute-Attenuation.su"
PARAM_A0="-8e-4"
PARAM_A1="8e-4"
PARAM_B0="-1e-7"
PARAM_B1="1e-7"
PARAM_C0="2e-6"
PARAM_C1="4.4e-7"
PARAM_NA="5"
PARAM_NB="5"
PARAM_NC_CMP="5"
PARAM_NC_CRS="5"
PARAM_APH="600"
PARAM_APM="50"
PARAM_TAU="0.002"
PARAM_NGEN="30"
PARAM_AZIMUTH="0"

elif [[ $FOLD1000 -eq 1 ]]; then
DATASET="$HOME/Data/fold1000.su"
PARAM_A0="-0.7e-3"
PARAM_A1="0.7e-3"
PARAM_B0="-1e-7"
PARAM_B1="1e-7"
PARAM_C0="1.975e-7"
PARAM_C1="1.384e-6"
PARAM_NA="5"
PARAM_NB="5"
PARAM_NC_CMP="5"
PARAM_NC_CRS="101"
PARAM_APH="2600"
PARAM_APM="50"
PARAM_TAU="0.004"
PARAM_NGEN="30"
PARAM_AZIMUTH="90"

elif [[ $SIMPLE_SINTETIC -eq 1 ]]; then
DATASET="$HOME/Data/simple-synthetic.su"
PARAM_A0="-0.7e-3"
PARAM_A1="0.7e-3"
PARAM_B0="-1e-7"
PARAM_B1="1e-7"
PARAM_C0="1.98e-7"
PARAM_C1="11.77e-6"
PARAM_NA="5"
PARAM_NB="5"
PARAM_NC_CMP="5"
PARAM_NC_CRS="5"
PARAM_APH="600"
PARAM_APM="50"
PARAM_TAU="0.002"
PARAM_NGEN="30"
PARAM_AZIMUTH="0"

fi

DATA=${DATASET##*/}
DATA=${DATA%.su}

if [ ! -e  $DATASET ]; then
    echo " * * * * * * * * * * * * * * * * * * * * * * * * * Dataset not found! * * * * * * * * * * * * * * * * * * * * * * * * * "
    # exit
fi

echo "Executing $DATA"

RESULT_DIR="${ROOT_DIR}/result_`hostname`_DATA-${DATA}_NA-${PARAM_NA}_NB-${PARAM_NB}_NC-CMP-${PARAM_NC_CMP}_NC-CRS-${PARAM_NC_CRS}_`date +%d-%m-%Y`"

mkdir -p ${RESULT_DIR}


date > ${RESULT_DIR}/clinfo
clinfo >> ${RESULT_DIR}/clinfo



for benchmark in `seq 1 ${#NAMES[@]}`; do
	NAME=${NAMES[benchmark]}
	echo "Executing $NAME..."
	echo `date`
	EXECUTABLE=bin/${EXECUTABLES[benchmark]}
	cd ${ROOT_DIR}/${DIRECTORIES[benchmark]}
	echo "Going to run $NAME $EXECUTABLE on $PWD"
	if [ ! -e ${EXECUTABLE} ]; then
	  echo "Excecutable $EXECUTABLE not found"
	  continue
	fi

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-aph ${PARAM_APH} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-nc ${PARAM_NC_CMP} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CMP}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CMP}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh
done



#CMP-OpenCL
NAME=CMP-OpenCL
echo "Executing $NAME..."
echo `date`
EXECUTABLE=bin/cmp-ocl2
cd ${ROOT_DIR}/CMP/OpenCL

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-aph ${PARAM_APH} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-d ${PARAM_D} \
	-nc ${PARAM_NC_CMP} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CMP}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CMP}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh



#CRS-CUDA
NAME=CRS-CUDA
	echo "Executing $NAME..."
	echo `date`
EXECUTABLE=bin/crs-cuda
cd ${ROOT_DIR}/CRS/CUDA

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
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
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh


if [[ ! -z "${OPENACC}" ]]; then

	#CRS-OpenACC
	NAME=CRS-OpenACC
	echo "Executing $NAME..."
	echo `date`
	EXECUTABLE=bin/crs-acc
	cd ${ROOT_DIR}/CRS/OpenACC

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
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
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh
fi

#CRS-OpenCL
NAME=CRS-OpenCL
	echo "Executing $NAME..."
	echo `date`
EXECUTABLE=bin/crs-ocl2
cd ${ROOT_DIR}/CRS/OpenCL

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-d ${PARAM_D} \
	-na ${PARAM_NA} \
	-nb ${PARAM_NB} \
	-nc ${PARAM_NC_CRS} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh


if [[ ! -z "${OPENMP}" ]]; then

	#CRS-OpenMP
	NAME=CRS-OpenMP
		echo "Executing $NAME..."
	EXECUTABLE=bin/crs-omp2
	echo `date`
	cd ${ROOT_DIR}/CRS/OpenMP

	for type in ${TYPES[@]}; do
	cat << EOF > execute_${type}.sh
	#!/bin/bash
	for i in \`seq 1 $REPETITIONS\`; do
		time ( ./$EXECUTABLE \
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
		-i $DATASET ) \
		>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
		2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
	done
	EOF
	chmod +x execute_${type}.sh
	done
	./execute_host.sh
	mkdir -p ${RESULT_DIR}/output_${NAME}/host
	mv *.su ${RESULT_DIR}/output_${NAME}/host
	singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
	mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
	mv *.su ${RESULT_DIR}/output_${NAME}/singularity
	# rm execute_*.
fi

if [[ ! -z "${OPENACC}" ]]; then

	#CRS-DE-OpenACC
	NAME=CRS-DE-OpenACC
	echo "Executing $NAME..."
	echo `date`
	EXECUTABLE=bin/crs-acc-de
	cd ${ROOT_DIR}/CRS/OpenACC

for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
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
	-ngen ${PARAM_NGEN} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh
fi


#CRS-DE-OpenCL
NAME=CRS-DE-OpenCL
echo "Executing $NAME..."
echo `date`
EXECUTABLE=bin/crs-ocl-de
cd ${ROOT_DIR}/CRS-DE/OpenCL
for type in ${TYPES[@]}; do
cat << EOF > execute_${type}.sh
#!/bin/bash
for i in \`seq 1 $REPETITIONS\`; do
	time ( ./$EXECUTABLE \
	-a0 ${PARAM_A0} \
	-a1 ${PARAM_A1} \
	-aph ${PARAM_APH} \
	-apm ${PARAM_APM} \
	-azimuth ${PARAM_AZIMUTH} \
	-b0 ${PARAM_B0} \
	-b1 ${PARAM_B1} \
	-c0 ${PARAM_C0} \
	-c1 ${PARAM_C1} \
	-d ${PARAM_D} \
	-na ${PARAM_NA} \
	-nb ${PARAM_NB} \
	-nc ${PARAM_NC_CRS} \
	-ngen ${PARAM_NGEN} \
	-tau ${PARAM_TAU} \
	-v ${PARAM_V} \
	-i $DATASET ) \
	>> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_output.txt" \
	2> "${RESULT_DIR}/${NAME}_${type}_${DATA}_${PARAM_NA}_${PARAM_NB}_${PARAM_NC_CRS}_time.txt"
done
EOF
chmod +x execute_${type}.sh
done
./execute_host.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/host
mv *.su ${RESULT_DIR}/output_${NAME}/host
singularity exec --nv -B /usr/lib/x86_64-linux-gnu/ $IMAGE_PATH ./execute_singularity.sh
mkdir -p ${RESULT_DIR}/output_${NAME}/singularity
mv *.su ${RESULT_DIR}/output_${NAME}/singularity
# rm execute_*.sh

cd ${ROOT_DIR}
echo "* * * * * * * ${RESULT_DIR} * * * * * * * *"
ls ${RESULT_DIR}
echo "* * * * * * * ${RESULT_DIR}: * * * * * * * *"



# set +x