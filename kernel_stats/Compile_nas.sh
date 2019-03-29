cat config/make.def.template | \
sed "s/MPIF77 = f77/MPIF77 = mpif90/g" | \
sed "s/MPICC = cc/MPICC = mpicc/g" | \
sed "s/FLINKFLAGS = -O/FLINKFLAGS = -O ..\/bin\/kernel_stats.o/g" | \
sed "s/CLINKFLAGS = -O/CLINKFLAGS = -O ..\/bin\/kernel_stats.o/g" > config/make.def

# sed "s/FFLAGS  = -O/FFLAGS  = -O -ffree-form/g" | \

cp config/suite.def.template config/suite.def
np=64
for bench in bt cg ep ft is lu mg sp; do
    for size in A B C D; do
        echo "$bench    $size    $np" >> config/suite.def
	done
done



cd nas/NPB3.3.1/NPB3.3-MPI
cd kernel_stats
gcc -c kernel_stats.c
mkdir -p ../bin
mv kernel_stats.o ../bin
cd ../

make suite


# $ NPB3.3-OMP grepr "omp parallel"
# https://www.hoffman2.idre.ucla.edu/c-fortran-interop/
# http://geco.mines.edu/prototype/How_do_I_call_C_routines_from_Fortran/
