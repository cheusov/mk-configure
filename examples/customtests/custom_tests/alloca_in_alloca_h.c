#include <alloca.h>

int main (int argc, char **argv)
{
#ifndef alloca
	void *p = &alloca;
#endif
	return 0;
}
