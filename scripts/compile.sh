#!/bin/bash

SMALL=

size=64
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

  echo make -j "${bench}" NPROCS="${nprocs}" CLASS="${class}"
}

for bench in $BENCH; do
	for class in $CLASSES; do
		compile_bench "${bench}" ${size} "${class}"
	done
done


for class in A B C D; do
  compile_bench lu 32 "${class}"
  compile_bench sp 25 "${class}"
  compile_bench sp 36 "${class}"
  compile_bench bt 25 "${class}"
  compile_bench bt 36 "${class}"
done