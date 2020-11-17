#include <stdio.h>

void puts_stdout (const char *);

void puts_stdout (const char *s)
{
	printf ("client: ");
	puts (s);
}
