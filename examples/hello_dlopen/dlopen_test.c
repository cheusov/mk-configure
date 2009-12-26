#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>

int main (int argc, char **argv)
{
	void *p = NULL;

	p = dlopen (LIBC_FN, RTLD_LAZY);
	if (p){
		printf ("returned address: %p\n", p);
		dlclose (p);
	}else{
		fprintf (stderr, "dlopen(3) failed: %s\n", dlerror ());
		return 1;
	}

	return 0;
}
