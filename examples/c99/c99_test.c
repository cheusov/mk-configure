#include <stdio.h>
#include "inline_func.h"

int sum(int a, int b);

int main(int argc, char **argv)
{
	printf("2+2=%d\n", sum(2, 2));
	return 0;
}
