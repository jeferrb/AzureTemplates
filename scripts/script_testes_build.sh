#!/bin/bash

export ACC_DEVICE_TYPE=host
ROOT_DIR="/home/username/OpenCL-seismic-processing-tiago"

cd $ROOT_DIR/

PROGRAM=CMP

#CMP-CUDA
NAME=CUDA

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

make -j
cd $ROOT_DIR/

#CMP-CUDAfp16
NAME=CUDAfp16

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

make -j
cd $ROOT_DIR/

#CMP-OpenACC
NAME=OpenACC

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

#CMP-CUDAfp16
NAME=CUDAfp16

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

make -j
cd $ROOT_DIR/

#CMP-OpenCL
NAME=OpenCL

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

#CMP-OpenMP
NAME=OpenMP

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

PROGRAM=CRS

#CRS-CUDA
NAME=CUDA

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

make -j
cd $ROOT_DIR/

#CRS-OpenACC
NAME=OpenACC

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

#CRS-OpenCL
NAME=OpenCL

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

#CRS-OpenMP
NAME=OpenMP

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

PROGRAM=CRS-DE

#CRS-DE-OpenACC
NAME=OpenACC

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/

#CRS-DE-OpenCL
NAME=OpenCL

cd ${ROOT_DIR}/${PROGRAM}/${NAME}/

if [ ! -d "bin" ]; then
  mkdir bin
fi

cd bin/
cmake -DCMAKE_BUILD_TYPE="Release" ../ && make -j
cd $ROOT_DIR/