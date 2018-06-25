#!/bin/bash

set -x

frequence=$1
name=`echo $2 | rev | cut -d'/' -f1 | rev`
perf record -F ${frequence} -o "${HOME}/${name}-${RANDOM}${RANDOM}${RANDOM}.perf.data" ${2}
