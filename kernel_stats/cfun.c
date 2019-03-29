#include <stdio.h>

// jeferson
extern void init_timestep_();
extern void begin_timestep_();
extern void end_timestep_(unsigned int maxsteps);


int main(int argc, char const *argv[])
{
	for (int i = 0; i < 10000; ++i)
	{
		begin_timestep_();
		// Code goes here
		end_timestep_(9999);
	}
	return 0;
}
