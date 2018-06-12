#!/bin/bash

frequence=$1
name=$2

perf record -F ${frequence} -o "${name}_rep-${i}.perf.data" ${name} 
