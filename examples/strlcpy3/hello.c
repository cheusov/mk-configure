#include <stdio.h>
#include <string.h>

#include <mkc_strlcpy.h>
#include <mkc_strlcat.h>
#include <mkc_getline.h>
#include <mkc_progname.h>

static const char message [] = "Theo de Raadt said: \"The strlcpy() and strlcat() functions provide a consistent, unambiguous API to help the programmer write more bullet-proof code.\"";

int main (int argc, char ** argv)
{
	char *buf = NULL;
	size_t size = 0;
	ssize_t len = 0;
	char small_buf [15];
	char said [19];

	setprogname(argv [0]);

	while (len = getline(&buf, &size, stdin), len != -1){
		if (len > 0 && buf[len-1] == '\n')
			buf[len-1] = 0;

		strlcpy(small_buf, "foo17", sizeof(small_buf));
		strlcat(small_buf, buf, sizeof(small_buf));
		puts(small_buf);
	}

	strlcpy(said, message, sizeof(said));
	puts(said);

	printf("short progname=%s\n", getprogname());
	printf("full progname=%s\n", argv[0]);

	return 0;
}
