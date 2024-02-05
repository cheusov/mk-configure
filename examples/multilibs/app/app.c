#include <stdio.h>
#include <stdlib.h>
#include <summator.h>
#include <multiplier.h>

int main(int argc, char **argv) {
	--argc;
	++argv;

	int a = atoi(argv[0]);
	int b = atoi(argv[1]);

	printf("%d\n", sum(multiply(a, a), multiply(b, b)));
	return 0;
}
