#include <stdio.h>

#include "bar.h"

int main (int argc, char** argv)
{
	printf ("%s", get_msg2 ());
	printf ("%d\n", NUM);
	return 0;
}
