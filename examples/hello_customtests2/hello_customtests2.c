#include <stdio.h>

#if HAVE_CUSTOM_ALLOCA_IN_STDLIB_H
#include <stdlib.h>
#elif HAVE_CUSTOM_ALLOCA_IN_ALLOCA_H
#include <alloca.h>
#endif

int main (int argc, char** argv)
{
	if (alloca (100))
		puts ("alloca(3) succeeded");
	else
		puts ("alloca(3) failed");

	return 0;
}
