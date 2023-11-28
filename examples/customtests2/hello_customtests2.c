#include <stdio.h>

#if CUSTOM_ALLOCA_IN_STDLIB_H
#include <stdlib.h>
#elif CUSTOM_ALLOCA_IN_ALLOCA_H
#include <alloca.h>
#endif

int main (int argc, char** argv)
{
	void *p=alloca(100);
	if (p)
		printf("alloca(3) succeeded %p\n", p);
	else
		puts("alloca(3) failed");

	return 0;
}
