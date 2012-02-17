#include <stdio.h>

void puts_stdout (const char *);

void puts_stdout (const char *s)
{
	printf ("server: ");
	puts (s);
}
