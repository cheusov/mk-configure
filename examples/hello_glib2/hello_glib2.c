#include <glib.h>
#include <locale.h>
#include <stdio.h>

int main (int argc, char** argv)
{
	setlocale (LC_ALL, "");

	puts ("Hello World!");

	printf ("glib_major_version=%i\n", (int) glib_major_version);
	printf ("glib_minor_version=%i\n", (int) glib_minor_version);
	printf ("glib_micro_version=%i\n", (int) glib_micro_version);

	return 0;
}
