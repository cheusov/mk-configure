#include <stdio.h>
#include <string.h>

#ifndef HAVE_FUNC3_STRLCPY_STRING_H
size_t strlcpy(char *dst, const char *src, size_t siz);
#endif

int main ()
{
	char buf [2000];
	char small_buf [10];

	size_t len;

	while (fgets (buf, sizeof (buf), stdin)){
		len = strlen (buf);
		if (len > 0 && buf [len-1] == '\n')
			buf [len-1] = 0;

		strlcpy (small_buf, buf, sizeof (small_buf));
		puts (small_buf);
	}

	return 0;
}
