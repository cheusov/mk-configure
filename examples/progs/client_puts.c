#include <mkc_dprintf.h>

void puts_stdout (const char *);

void puts_stdout (const char *s)
{
	dprintf(1, "client: %s\n", s);
}
