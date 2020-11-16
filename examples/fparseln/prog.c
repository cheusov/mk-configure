#include <stdio.h>
#include <stdlib.h>

#include <mkc_fparseln.h>

int main(int argc, char *argv[])
{
	char *line = NULL;
	size_t len = 0;
	size_t lineno = 0;
	while ((line = fparseln(stdin, &len, &lineno, NULL, 0)) != NULL){
		printf("%lu %lu %s\n", (long unsigned)lineno, (long unsigned)len, line);
	}
	free(line);

	return 0;
}
