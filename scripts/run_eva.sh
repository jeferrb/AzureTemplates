mkdir $HOME/shared_fs
sudo bash -c 'echo "//disco123.file.core.windows.net/shared $HOME/shared_fs cifs nofail,vers=3.0,username=disco123,password=vHjb5pXkkOO4RQlHWAehIExiclRtth14qpxEYKDHamJWLMbY23M+u/6iwbwRJUbAgUzGoQboj/syz0moB2PJZw==,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
sudo mount -a

cd AzureTemplates
mkdir results



AZURE_MACHINES=55
NUMBER_INSTANCES=1
./scripts/run_mpi_benchmark_eva.sh jsdhfasdfasdf123123 vHjb5pXkkOO4RQlHWAehIExiclRtth14qpxEYKDHamJWLMbY23M+u/6iwbwRJUbAgUzGoQboj/syz0moB2PJZw== ${AZURE_MACHINES} ${NUMBER_INSTANCES} 2>&1 | tee -a "results/run_mpi_benchmark_`date +%d-%m-%Y`_${AZURE_MACHINES}_${NUMBER_INSTANCES}.log" &
