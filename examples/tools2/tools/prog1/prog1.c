#include <stdio.h>

#include "foo.h"

int main (int argc, char** argv)
{
	printf ("%s", get_msg1 ());
	printf ("%d\n", NUM);
	return 0;
}
