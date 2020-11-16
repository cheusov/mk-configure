#include <string.h>

#include <mkc_reallocarray.h>

int main(int argc, char *argv[])
{
	char *ptr = reallocarray(NULL, 12, sizeof(*ptr));
	strcpy(ptr, "I am happy!");
	puts(ptr);

	return 0;
}
