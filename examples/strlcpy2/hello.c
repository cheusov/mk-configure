#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifndef HAVE_FUNC3_STRLCPY_STRING_H
size_t strlcpy(char *dst, const char *src, size_t siz);
#endif

#ifndef HAVE_FUNC3_GETLINE_STDIO_H
ssize_t getline(char** lineptr, size_t* n, FILE* stream);
#endif

int main (int argc, char ** argv)
{
	char *buf = NULL;
	size_t size = 0;
	ssize_t len = 0;
	char small_buf [10];

	while (len = getline (&buf, &size, stdin), len != -1){
		len = strlen (buf);
		if (len > 0 && buf [len-1] == '\n')
			buf [len-1] = 0;

		strlcpy (small_buf, buf, sizeof (small_buf));
		puts (small_buf);
	}

	return 0;
}
