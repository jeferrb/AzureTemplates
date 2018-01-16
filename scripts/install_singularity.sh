#!/bin/bash

VERSION=2.4

sudo apt-get -y update
sudo apt-get install -y wget make gcc openmpi-bin openmpi-common
wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make -j
sudo make install
