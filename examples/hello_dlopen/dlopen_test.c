#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>

int main (int argc, char **argv)
{
	void *p = NULL;

	p = dlopen (LIBC_FN, RTLD_LAZY);
	printf ("returned address: %p\n", p);
	dlclose (p);

	return 0;
}
