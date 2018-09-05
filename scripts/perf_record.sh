#!/bin/bash

set -x

frequence=$1
name=`echo $2 | rev | cut -d'/' -f1 | rev`
time perf record -F ${frequence} -o "${HOME}/${name}_${3}-${RANDOM}${RANDOM}${RANDOM}.perf.data" ${2}
