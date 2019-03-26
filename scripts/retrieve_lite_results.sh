find results_2*-01-2019 -type d > dirs.txt
mkdir results_jan_2019_lite
cd results_jan_2019_lite
xargs mkdir -p < ../dirs.txt
cd ../
find results_2*-01-2019 -type f -not -name "*.perf.data" -exec echo cp {} results_jan_2019_lite/{} \; > copy.sh
sh copy.sh
