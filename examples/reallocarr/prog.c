#include <stdio.h>
#include <string.h>

#include <mkc_reallocarr.h>
#include <mkc_errc.h>

int main(int argc, char *argv[])
{
	int *data = NULL;
	int ret = 0;

	ret = reallocarr(&data, 16, sizeof(*data));
	if (ret)
		errc(1, ret, "reallocarr failed");

	printf("Allocated pointer: %p\n", data);

	ret = reallocarr(&data, 256, sizeof(*data));
	if (ret)
		errc(1, ret, "reallocarr failed on resize");

	printf("Allocated pointer: %p\n", data);

	free(data);

	return 0;
}
