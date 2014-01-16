#include <stdio.h>
#include <stdlib.h>

int main (int argc, char** argv)
{
#if HAVE_PKGCONFIG_ZZZ
	abort (); /* this should not happen */
#else
	puts ("pkg-config module 'zzz' was not found");
#endif

	return 0;
}
