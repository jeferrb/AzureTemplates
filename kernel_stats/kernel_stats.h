/* Measure kernel iterations based on 'Cross-Platform Performance Prediction of
Parallel Applications Using Partial Execution' paper */

#ifndef KERNEL_STATS_H
#define KERNEL_STATS_H 1

#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>



#ifndef PREFIX_TIME_MSG
#define PREFIX_TIME_MSG "****TIME*** "
#endif
#ifndef PREFIX_ITERATION_MSG
#define PREFIX_ITERATION_MSG "iteration "
#endif

/* This is an optional call to time-stamp the beginning of an execution. For
applications with large start-up overhead, e.g., due to reading large data sets
from secondary storage, this call may be used to separate the initialization
overhead from subsequent regular timesteps */ 
void init_timestep_();

/* This call identifies the beginning of a timestep and allows counters for
metrics to be reset between timesteps */ 
void begin_timestep_();

/* This call indicates the end of a timestep and logs metrics pertinent to the
timestep work. The parameter maxsteps specifies the total number of timesteps
before partial execution prematurely terminates the program's execution */
void end_timestep_(int maxsteps);

#endif
