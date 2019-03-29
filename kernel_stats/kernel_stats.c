#include "kernel_stats.h"


struct timeval least_start_loop, least_end_loop;
unsigned int max_steps = 1, started = 0;

void init_timestep_(){
	gettimeofday(&least_end_loop, NULL);
	printf("%sStarting at: %ld ms\n", PREFIX_TIME_MSG, (least_end_loop.tv_sec * 1000000 + least_end_loop.tv_usec));
	started=1;
}

void begin_timestep_(){
	gettimeofday(&least_start_loop, NULL);
	if (!started)
	{
		init_timestep_();
	}
}

void end_timestep_(int maxsteps){
	gettimeofday(&least_end_loop, NULL);
	printf("%s%ld ms\n", PREFIX_TIME_MSG,  ((least_end_loop.tv_sec * 1000000 + least_end_loop.tv_usec) - (least_start_loop.tv_sec * 1000000 + least_start_loop.tv_usec)));
	if (++max_steps > maxsteps)
	{
		printf("%sExiting at iteration: %d\n", PREFIX_TIME_MSG, maxsteps);
		exit (0);
	}
	gettimeofday(&least_end_loop, NULL);
}

int maino_(){
	for (int i = 0; i < 100; ++i)
	{
		begin_timestep_();
		for (int i = 0; i < 100000; ++i)
		{
			printf("aslkdfalskdf\n");
		}
		end_timestep_(3);
	}
	return 0;
}
