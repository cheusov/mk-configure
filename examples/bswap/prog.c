#include <stdio.h>
#include <stdint.h>
#include <mkc_bswap.h>

static const uint64_t one64 = 1;
static const uint32_t one32 = 1;
static const uint64_t one16 = 1;

int main (int argc, char **argv)
{
	printf("bswap16: %lx\n", (long unsigned) bswap16(one16));
	printf("bswap32: %lx\n", (long unsigned) bswap32(one32));
	printf("bswap64: %llx\n", (long long unsigned) bswap64(one64));
	return 0;
}
