#!/bin/bash

export ACC_DEVICE_TYPE=host
ROOT_DIR="/home/$USER/OpenCL-seismic-processing-tiago"





#--------PROGRAM---------
PROGRAM=CMP

#CMP-CUDA
NAME=CUDA
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-CUDAfp16
NAME=CUDAfp16
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-OpenACC - NOT
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CMP-CUDAfp16
NAME=CUDAfp16
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CMP-OpenCL
NAME=OpenCL
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CMP-OpenMP
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j




#--------PROGRAM---------
PROGRAM=CRS-DE

#CRS-DE-OpenACC - NOT
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CRS-OpenMP
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#--------PROGRAM---------
PROGRAM=CRS

#CRS-CUDA
NAME=CUDA
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
make -j


#CRS-OpenACC - NOT
NAME=OpenACC
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


#CRS-OpenCL
NAME=OpenCL
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j



# export CC=gcc-7
# export CXX=g++-7
#CRS-OpenMP
NAME=OpenMP
cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
if [ ! -d "bin" ]; then
  mkdir bin
fi
cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j


cd $ROOT_DIR/


# #CRS-DE-OpenCL
# NAME=OpenCL
# cd ${ROOT_DIR}/${PROGRAM}/${NAME}/
# if [ ! -d "bin" ]; then
#   mkdir bin
# fi
# cd bin/
# cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
