#include <stdio.h>
#include <errno.h>

#include <mkc_errc.h>
#include <mkc_progname.h>

static const char bad_filename[] = "/bad/file.txt";

int main (int argc, char **argv)
{
	setprogname("prog");

	FILE *fd = fopen(bad_filename, "r");
	if (!fd)
		errc(15, errno, "Cannot open file %s", bad_filename);

	return 0;
}
