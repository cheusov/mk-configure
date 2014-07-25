#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <mkc_fgetln.h>
#include <mkc_err.h>

int main (int argc, char ** argv)
{
	char *buf, *lbuf;
	size_t len;

	while ((lbuf = buf = fgetln (stdin, &len)) != NULL) {
		if (len > 0 && buf [len - 1] == '\n')
			buf[len - 1] = '\0';
		else if ((lbuf = strndup (buf, len + 1)) == NULL)
			err (1, NULL);
		printf ("%s\n", lbuf);

		if (lbuf != buf)
			free (lbuf);
	}
	return 0;
}
