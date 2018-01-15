#!/bin/bash

VERSION=2.4

apt-get install -y wget make gcc openmpi-bin openmpi-common
wget -q https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=/usr/local
make
sudo make install
