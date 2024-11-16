#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#include <mkc_posix_getopt.h>

int main(int argc, char *argv[])
{
	int flags, opt;
	int nsecs, tfnd;

	nsecs = 0;
	tfnd = 0;
	flags = 0;
	while ((opt = getopt(argc, argv, "nt:")) != -1) {
		switch (opt) {
			case 'n':
				flags = 1;
				break;
			case 't':
				nsecs = atoi(optarg);
				tfnd = 1;
				break;
			default: /* '?' */
				fprintf(stderr, "Usage: %s [-t nsecs] [-n] name\n",
						argv[0]);
				exit(EXIT_FAILURE);
		}
	}
	argc -= optind;
	argv += optind;

	printf("flags=%d; tfnd=%d; nsecs=%d; optind=%d\n",
		   flags, tfnd, nsecs, optind);

	if (argc > 0)
		printf("free argument = %s\n", argv[0]);

	exit(EXIT_SUCCESS);
}
