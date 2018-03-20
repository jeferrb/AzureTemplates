#!/bin/bash

SMALL=

size=32
declare -a BENCH=(bt cg dt ep ft is lu mg sp)
if [[ ${SMALL} ]]; then
	declare -a CLASSES=(s)
else
	declare -a CLASSES=(A B C D)
fi


# compile_bench(bench, nprocs, class)
compile_bench() {
  local bench="${1}"
  local nprocs="${2}"
  local class="${3}"

  make -j2 "${bench}" NPROCS="${nprocs}" CLASS="${class}"
}

for bench in $BENCH; do
	./compile.sh 
	for class in $CLASSES; do
		compile_bench "${bench}" ${size} "${class}"
	done
done
