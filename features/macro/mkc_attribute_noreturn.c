#include <stdlib.h>

void err_exit() __attribute__ ((noreturn));

void err_exit(int status)
{
	exit(status);
}
