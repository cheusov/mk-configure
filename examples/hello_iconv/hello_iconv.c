#include <stdio.h>

int main (int argc, char ** argv)
{
	static char compat [] =
#ifdef HAVE_PROTOTYPE_POSIX_ICONV
		"compatible";
#elif defined(HAVE_PROTOTYPE_CONST_ICONV)
		"incompatible";
#else
		"???";
#endif

	printf ("Your iconv(3) is %s with POSIX\n", compat);

#if defined(HAVE_PROTOTYPE_POSIX_ICONV) && defined(HAVE_PROTOTYPE_CONST_ICONV)
	puts ("Buggy mk-configure!");
#endif

	return 0;
}
