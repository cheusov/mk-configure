#include <stdio.h>

#include <mkc_humanize_number.h>
#include <mkc_err.h>

static void print(int64_t bytes)
{
	char buffer[9];
	if (-1 == humanize_number(
			buffer, sizeof(buffer),
			bytes, "", HN_AUTOSCALE, HN_B | HN_NOSPACE))
	{
		err(1, "humanize_number");
	}

	printf("%lu bytes is aproximately %s\n", (unsigned long)bytes, buffer);
}

int main(int argc, char **argv)
{
	print(1l);
	print(10l);
	print(100l);
	print(1000l);
	print(10000l);
	print(100000l);
	print(1000000l);
	print(10000000l);
	print(100000000l);
	print(1000000000l);
	print(10000000000l);
	print(100000000000l);
	print(1000000000000l);
	print(10000000000000l);

	return 0;
}
