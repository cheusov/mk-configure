#include <stdio.h>
#include <mkc_arc4random.h>

int main (int argc, char **argv)
{
	uint32_t random = arc4random();
	printf("random: %lu\n", (long unsigned) random);
	return 0;
}
