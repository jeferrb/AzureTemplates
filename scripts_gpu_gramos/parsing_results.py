import subprocess
import re
import csv

# Use this to get your files
copy_command = ''#scp -r username@SERVERIP:/home/username/OpenCL-seismic-processing-tiago/Result results_gpu_`date +%d_%m_%y`_X'

# Use this to generate a results_all.log
parse_command = ''#find . -type f -print -iname "*.txt" -exec sh -c "cat {} | grep 'Execution Time'" \; > result_all.log'

# subprocess.Popen(copy_command.split(),stdout=subprocess.PIPE)
# subprocess.Popen(parse_command.split(),stdout=subprocess.PIPE)

kernel_times = {}
total_times = {}
current_test = ''

with open('result_all.log','r') as result:
    for line in result:
        # New test started
        if 'output.txt' in line:
            current_test = '--'.join(line.split('_')[:2])[2:]
            kernel_times[current_test] = ''
            total_times[current_test] = ''
        # Getting the params for the current_test
        else:
            # no test being parsed atm
            if not current_test:
                continue
            # 0 is kernel and 1 is total
            if 'Kernel Execution Time' in line:
                kernel_times[current_test]+=(re.search('(?<=Kernel\sExecution\sTime\:\s)\d+\.\d+', line).group(0))+','
            if 'Total Execution Time' in line:
                total_times[current_test]+=(re.search('(?<=Total\sExecution\sTime\:\s)\d+\.\d+', line).group(0))+','
            elif ': Execution Time' in line:
                total_times[current_test]+=(re.search('(?<=\:\sExecution\sTime\:\s)\d+\.\d+', line).group(0))+','

with open('parsed_results.csv','wb') as final_file:
    final_file.write('TOTAL VALUES')
    for key,value in total_times.iteritems():
        final_file.write('\n'+key+'\n'+value)
    final_file.write('\n\nKERNEL VALUES')
    for key,value in kernel_times.iteritems():
        final_file.write('\n'+key+'\n'+value)