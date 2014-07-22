#include <errno.h>
#include <string.h>
#include <stdio.h>

#include <mkc_err.h>

int main (int argc, char ** argv)
{
	--argc;
	++argv;

	if (argc != 2)
		return (90);

	if (!strcmp (argv [0], "errx")){
		switch (argv [1][0]){
			case '1':
				errx (11, "err test1");
				break;
			case '2':
				errx (12, "err test2, five=%d", 5);
				break;
			default:
				fprintf (stderr, "err(3): invalid argv\n");
				return 93;
		}
	}else if (!strcmp (argv [0], "err")){
		switch (argv [1][0]){
			case '1':
				errno = ENOMEM;
				err (21, "errx test1");
				break;
			case '2':
				errno = ENOMEM;
				err (22, "errx test2, six=%d", 6);
				break;
			default:
				fprintf (stderr, "errx(3): invalid argv\n");
				return 94;
		}
	}else{
		fprintf (stderr, "bad err id '%s'\n", argv [0]);
		return (91);
	}

	return 0;
}
