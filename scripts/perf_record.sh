#!/bin/bash

set -x

frequence=$1
name=$2

perf record -F ${frequence} -m 512G -o "${name}-${RANDOM}${RANDOM}${RANDOM}.perf.data" ${name} 
