#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>

int main (int argc, char **argv)
{
	void *p = NULL;

	--argc, ++argv;

	if (argc != 1)
		return 1;

	p = dlopen (argv [0], RTLD_LAZY);
	printf ("returned address: %p\n", p);
	dlclose (p);

	return 0;
}
