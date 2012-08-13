#include <stdio.h>

#include "foo.h"
#include "bar.h"

int main (int argc, char** argv)
{
	printf ("%s", get_msg1 ());
	printf ("%d\n", NUM);

	printf ("%s", get_msg2 ());
	printf ("%d\n", NUM);
	return 0;
}
