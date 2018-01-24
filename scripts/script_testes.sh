#!/bin/bash

export ACC_DEVICE_TYPE=host
IMAGE_PATH="/home/username/ruycastilho-GPUtest-master.simg"
ROOT_DIR="/home/username/OpenCL-seismic-processing-tiago"
DATASET="/home/username/Data/simple-synthetic.su"

#CMP-CUDA
NAME=CMP-CUDA
EXECUTABLE=cmp-cuda

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CMP-CUDAfp16
NAME=CMP-CUDAfp16
EXECUTABLE=cmp-cudafp16

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CMP-CUDAfp32
NAME=CMP-CUDAfp32
EXECUTABLE=cmp-cudafp32

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CMP-OpenACC
NAME=CMP-OpenACC
EXECUTABLE=cmp-acc

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CMP-OpenCL
NAME=CMP-OpenCL
EXECUTABLE=cmp-ocl2

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-ngen 30 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-d 1 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-d 1 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CMP-OpenMP
NAME=CMP-OpenMP
EXECUTABLE=cmp-omp2

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-aph 600 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CRS-CUDA
NAME=CRS-CUDA
EXECUTABLE=crs-cuda

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CRS-OpenACC
NAME=CRS-OpenACC
EXECUTABLE=crs-acc

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#TYPE=singularity
#
#singularity shell --nv $IMAGE_PATH
#for i in 1 .. 10; do
#./$EXECUTABLE \
#-a0 -0.7e-3 \
#-a1 0.7e-3 \
#-na 5 \
#-c0 1.98e-7 \
#-c1 1.77e-6 \
#-nc 5 \
#-b0 -1e-7 \
#-b1 1e-7 \
#-nb 5 \
#-aph 600 \
#-apm 50 \
#-tau 0.002 \
#-v 4 \
#-i $DATASET \
#>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt
#
#done

#CRS-OpenCL
NAME=CRS-OpenCL
EXECUTABLE=crs-ocl2

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-d 1 \
-v 4 \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-d 1 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CRS-OpenMP
NAME=CRS-OpenMP
EXECUTABLE=crs-omp2

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#CRS-DE-OpenACC
NAME=CRS-DE-OpenACC
EXECUTABLE=crs-acc-de

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-ngen 30 \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

#TYPE=singularity
#
#singularity shell --nv $IMAGE_PATH
#for i in 1 .. 10; do
#./$EXECUTABLE \
#-ngen 30 \
#-a0 -0.7e-3 \
#-a1 0.7e-3 \
#-na 5 \
#-c0 1.98e-7 \
#-c1 1.77e-6 \
#-nc 5 \
#-b0 -1e-7 \
#-b1 1e-7 \
#-nb 5 \
#-aph 600 \
#-apm 50 \
#-tau 0.002 \
#-v 4 \
#-i $DATASET \
#>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

#done

#CRS-DE-OpenCL
NAME=CRS-DE-OpenCL
EXECUTABLE=crs-ocl-de

TYPE=host

for i in 1 .. 10; do
./$EXECUTABLE \
-ngen 30 \
-azimuth 0 \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-d 1 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done

TYPE=singularity

singularity shell --nv $IMAGE_PATH
for i in 1 .. 10; do
./$EXECUTABLE \
-ngen 30 \
-azimuth 0 \
-a0 -0.7e-3 \
-a1 0.7e-3 \
-na 5 \
-c0 1.98e-7 \
-c1 1.77e-6 \
-nc 5 \
-b0 -1e-7 \
-b1 1e-7 \
-nb 5 \
-aph 600 \
-apm 50 \
-tau 0.002 \
-d 1 \
-v 4 \
-i $DATASET \
>> ${ROOT_DIR}/Result/"$NAME"_"$TYPE".txt

done