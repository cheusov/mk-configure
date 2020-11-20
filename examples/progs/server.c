#include <stdlib.h>
#include <mkc_efun.h>

void puts_stdout (const char *);

int main (int argc, char **argv)
{
	char *ptr = estrdup("I am a server");
	puts_stdout (ptr);
	free(ptr);

	return 0;
}
