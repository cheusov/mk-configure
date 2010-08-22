#include <dlfcn.h>
#include <stdlib.h>
#include <stdio.h>

typedef void (*plugin_func_t) (void);

int main (int argc, char **argv)
{
	void *p [10];
	plugin_func_t s [10];
	int i;

	--argc; ++argv;

	if (argc >= 10){
		argc = 10;
	}

	for (i=0; i < argc; ++i){
		p [i] = dlopen (argv [i], RTLD_LAZY);
		if (p [i]){
			printf ("dlopen(3) returned address: %p\n", p [i]);
		}else{
			fprintf (stderr, "dlopen(3) failed: %s\n", dlerror ());
			return 1;
		}
	}
	puts ("");

	for (i=0; i < argc; ++i){
		s [i] = (plugin_func_t) dlsym (p [i], "hello_message");
		if (s [i]){
			printf ("dlsym(3) returned address: %p\n", s [i]);
			s [i] ();
		}else{
			fprintf (stderr, "dlsym(3) failed: %s\n", dlerror ());
			return 1;
		}
	}
	puts ("");

	for (i=0; i < argc; ++i){
		s [i] ();
	}

	return 0;
}
