# wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
# tar -zxf NPB3.3.1.tar.gz
cd NPB3.3.1/NPB3.3-MPI/

# cp config/make.def.template config/make.def
cat config/make.def.template | \
sed "s/MPIF77 = f77/MPIF77 = mpif90/g" | \
sed "s/MPICC = cc/MPICC = mpicc/g" > config/make.def

cp config/suite.def.template config/suite.def

for np in '16' '32' '64' '128' '256'; do
    for bench in bt cg ep ft is lu mg sp; do
        for size in A B C D; do
            echo "$bench    $size    $np" >> config/suite.def
        done
    done
done

# ------------------------

rm config/suite.def
size='E'
# for (( np = 1; np < 129; np++ )); do
for size in D E; do
    for np in '256' '512' '1024' '2048'; do
        for bench in bt cg ep ft is lu mg sp; do
            echo "$bench    $size    $np" >> config/suite.def
        done
    done
done

make suite


# Check
for bench in bt cg ft is lu mg sp; do
    echo "$bench"
    ls bin/$bench.$size.* | rev | cut -d '.' -f 1 | rev | sort -n # | wc -l 
done

# ------------------------

# size='D'
#     for bench in bt cg ep ft is lu mg sp; do
#         echo "$bench    $size    $np" >> config/suite.def
#     done
# done

# for bench in bt cg ep ft is lu mg sp; do
#     for size in A B C D; do
#         echo "$bench    $size"
#         ls bin/$bench.$size.* # | wc -l 
#     done
# done


# for bench in bt cg ep ft is lu mg sp; do
#         echo "$bench"
#         ls bin/$bench.* | wc -l 
# done


cd kernel_stats
gcc -c kernel_stats.c
mkdir -p ../bin
mv kernel_stats.o ../bin
cd ../


make suite

