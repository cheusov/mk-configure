#include <stdio.h>
#include <mkc_arc4random.h>

#define BUF_SIZE 6

int main (int argc, char **argv)
{
	uint32_t rnd = arc4random();
	printf("random: %llu\n", (long long unsigned) rnd);
	putc('\n', stdout);

	char buffer[BUF_SIZE];
	arc4random_buf(buffer, BUF_SIZE);
	for (int i = 0; i < BUF_SIZE; ++i){
		printf("buf[%d]: 0x%02x\n", i, (unsigned char) buffer[i]);
	}
	putc('\n', stdout);

	uint32_t rnd2b = arc4random_uniform(0x10000);
	printf("random %% 65536: 0x%04x\n", (unsigned) rnd2b);

	return 0;
}
