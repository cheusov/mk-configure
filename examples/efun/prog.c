#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <mkc_efun.h>

#define BUF_SIZE 100

int main (int argc, char **argv)
{
	char *buffer = ecalloc(BUF_SIZE, 1);
	char *copy;
	FILE *fd;
	uintmax_t uval;
	intmax_t sval;

	estrlcpy(buffer, "Hello", BUF_SIZE);
	estrlcat(buffer, " World!", BUF_SIZE);
	puts(buffer);

	copy = estrdup(buffer);
	copy[5] = '!';
	copy[6] = '\0';
	puts(copy);
	free(copy);

	easprintf(&copy, "%s\n%s\n%s", buffer, buffer, buffer);
	puts(copy);
	free(copy);

	copy = estrndup(buffer, 5);
	puts(copy);
	free(copy);

	copy = emalloc(200);
	estrlcpy(copy, buffer, 200);
	puts(copy);
	free(copy);
	copy = NULL;

	ereallocarr(&copy, 200, 1);
	estrlcpy(copy, buffer, 200);
	puts(copy);
	free(copy);
	copy = NULL;

	fd = efopen("/dev/null", "r");
	fclose(fd);

	uval = estrtou("111", 10, 0, 999);
	printf("%" PRIuMAX "\n", uval);

	sval = estrtoi("-111", 10, -999, 999);
	printf("%" PRIdMAX "\n", sval);

	return 0;
}
