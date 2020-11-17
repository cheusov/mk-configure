#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>

typedef void (*plugin_func_t) (void);

/* Function "putter" is for plugins only, it is not used by
   application. On some platforms it is not exported by default, this
   is why EXPORT_DYNAMIC is set to "yes"
*/
void putter (char *s);
void putter (char *s)
{
	printf ("%s\n", s);
}

int main (int argc, char **argv)
{
	void *pd;
	plugin_func_t f;
	int i;

	--argc; ++argv;

	for (i=0; i < argc; ++i){
		pd = dlopen (argv [i], RTLD_LAZY);
		if (!pd){
			fprintf (stderr, "dlopen(3) failed: %s\n", dlerror ());
			return 1;
		}

		f = (plugin_func_t) dlsym (pd, "print_message");
		if (!f){
			fprintf (stderr, "dlsym(3) failed: %s\n", dlerror ());
			return 1;
		}

		f ();

		if (dlclose (pd)){
			fprintf (stderr, "dlclose(3) failed: %s\n", dlerror ());
			return 1;
		}
	}

	return 0;
}
