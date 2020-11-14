#include <stdio.h>
#include <stdint.h>
#include <mkc_dprintf.h>

int main (int argc, char **argv)
{
	dprintf(2, "Hello %s!\n", "World");
	return 0;
}
