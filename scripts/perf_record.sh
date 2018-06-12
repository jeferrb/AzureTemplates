#!/bin/bash

set -x

frequence=$1
name=$2

perf record -F ${frequence} -o "${name}-${RANDOM}${RANDOM}${RANDOM}.perf.data" ${name} 
