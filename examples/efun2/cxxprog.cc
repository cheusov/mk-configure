#include <iostream>
#include <cstdlib>

#include <mkc_efun.h>

#define BUF_SIZE 100

int main (int argc, char **argv)
{
	void *buffer = ecalloc(BUF_SIZE, 1);
	std::cout << "cxxprog: ecalloc succeded\n";
	free(buffer);

	return 0;
}
