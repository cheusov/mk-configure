#include <stdio.h>
#include <stdlib.h>

#include <mkc_vis.h>

int main(int argc, char *argv[])
{
	char buffer[130];
	char *ptr;
	ptr = buffer + strvis(buffer, "string\tafter tab\034", VIS_CSTYLE);
	ptr = vis(ptr, '\r', VIS_CSTYLE, 0);
	puts(buffer);

	return 0;
}
