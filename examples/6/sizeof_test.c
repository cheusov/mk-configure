#include <stdio.h>

int main ()
{
	printf ("sizeof(int)=%i\n", SIZEOF_INT);
	printf ("sizeof(long)=%i\n", SIZEOF_LONG);
#ifdef SIZEOF_LONG_LONG
	printf ("sizeof(long long)=%i\n", SIZEOF_LONG_LONG);
#else
	printf ("long long type is absent\n");
#endif
#ifdef SIZEOF_SIZE_T_STRING_H
	printf ("sizeof(size_t)=%i\n", SIZEOF_SIZE_T_STRING_H);
#else
	printf ("size_t type is absent???\n");
#endif
	printf ("sizeof(void*)=%i\n", SIZEOF_VOIDP);

	return 0;
}
