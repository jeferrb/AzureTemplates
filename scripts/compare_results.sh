#!/bin/bash

ROOT_DIR="$HOME/OpenCL-seismic-processing-tiago/"

declare -a ALGORITHMS=(CMP CRS CRS-DE)
cd ROOT_DIR

# find . -iname "*.su"
# find . -iname "*.su" -exec du -h {} \;

# DATA=${DATASET##*/}
# DATA=${DATA%.su}

for algorithm in $ALGORITHMS; do
    # echo "Algorithm: $algorithm"
    for result in ${algorithm}/OpenCL/*.su; do
        result=${result##*/}
        # echo "Result $result"
        for implementation in ${algorithm}/*; do
            # echo "Implementation $implementation"
            # echo diff ${algorithm}/OpenCL/${result} ${implementation}/${result} 
            diff ${algorithm}/OpenCL/${result} ${implementation}/${result}  2> /dev/null
        done
    done
done
