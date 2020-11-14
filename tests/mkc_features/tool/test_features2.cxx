#include <stdio.h>

#include "mkc_err.h"

int main(int argc, char** argv)
{
	err(0, "error: %s", "error");

	return 0;
}
