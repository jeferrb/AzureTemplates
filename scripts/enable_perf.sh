sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
sudo sh -c 'echo 0 > /proc/sys/kernel/kptr_restrict'


sudo sh -c 'echo kernel.perf_event_paranoid=1 >> /etc/sysctl.d/local.conf'
sudo sh -c 'echo kernel.kptr_restrict=0 >> /etc/sysctl.d/local.conf'



declare -a BENCHS=(sp cg ep ft is lu mg sp bt)
declare -a CLASSES=(A B C D)
for bench in "${BENCHS[@]}"; do
    for class in "${CLASSES[@]}"; do
      echo "Runing ${bench} ${class} $SIZE"
      # perf record -o "${bench}.${class}.perf.data" ./${bench}.${class}.x
      perf record -o "${bench}.${class}.perf.data" mpirun -np 64 -- ${bench}.${class}.64 > ${bench}.${class}.64.log  2>  ${bench}.${class}.64.error.log
      cp ${bench}.${class}.perf.data ${bench}.${class}.64.log ${bench}.${class}.64.error.log /home/username/mymountpoint/perf_MPI &
    done
done



A
  61.39%  is.A.x   is.A.x            [.] rank._omp_fn.4
  32.43%  is.A.x   is.A.x            [.] randlc
   2.93%  is.A.x   is.A.x            [.] full_verify._omp_fn.2
   2.41%  is.A.x   is.A.x            [.] create_seq._omp_fn.0
B
  60.92%  is.B.x   is.B.x            [.] rank._omp_fn.4
  30.68%  is.B.x   is.B.x            [.] randlc
   5.73%  is.B.x   is.B.x            [.] full_verify._omp_fn.2
   1.98%  is.B.x   is.B.x            [.] create_seq._omp_fn.0
C
  60.18%  is.C.x   is.C.x            [.] rank._omp_fn.4
  28.33%  is.C.x   is.C.x            [.] randlc
   9.04%  is.C.x   is.C.x            [.] full_verify._omp_fn.2
   1.87%  is.C.x   is.C.x            [.] create_seq._omp_fn.0
D

BT 
A

B

C

D

