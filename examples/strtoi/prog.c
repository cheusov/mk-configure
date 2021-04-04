#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <errno.h>

#include <mkc_getline.h>
#include <mkc_strtoi.h>

int main (int argc, char ** argv)
{
	char *buf = NULL;
	size_t size = 0;
	ssize_t len = 0;
	intmax_t val;
	int rstatus;

	while (len = getline(&buf, &size, stdin), len != -1){
		if (len > 0 && buf[len-1] == '\n')
			buf[len - 1] = 0;

		val = strtoi(buf, NULL, 10, 0, 99, &rstatus);
		switch (rstatus){
			case ECANCELED:
				puts("ECANCELED");
				break;
			case EINVAL:
				puts("EINVAL");
				break;
			case ENOTSUP:
				puts("ENOTSUP");
				break;
			case ERANGE:
				puts("ERANGE");
				break;
			case 0:
				printf("Correct value %" PRIdMAX "\n", val);
				break;
			default:
				abort();
		}
	}

	return 0;
}
