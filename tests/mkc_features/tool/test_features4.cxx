#include <stdio.h>

#include "mkc_errc.h"

int main(int argc, char** argv)
{
	errc(1, 0, "error");
	return 0;
}
