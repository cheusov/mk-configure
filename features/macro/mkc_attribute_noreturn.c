#include <stdlib.h>

void test_func() __attribute__ ((noreturn));

void test_func(int status)
{
	exit(status);
}
