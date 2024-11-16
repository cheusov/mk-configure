#include <stdio.h>
#include <stdlib.h>

#include <mkc_efun.h>

#define BUF_SIZE 100

int main (int argc, char **argv)
{
	char *buffer = ecalloc(BUF_SIZE, 1);
	printf("ecalloc succeded\n");
	free(buffer);

	return 0;
}
