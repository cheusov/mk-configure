#include <stdio.h>
#include <string.h>
#include <errno.h>

#include <mkc_efun.h>
#include <mkc_err.h>
#include <mkc_getline.h>
#include <mkc_shquote.h>

int main(int argc, char **argv)
{
	char *buf = NULL;
	char *old_buf = NULL;
	size_t size;
	size_t len;

	char *shquoted_buf = NULL;

	while (len = getline(&buf, &size, stdin), len != -1){
		if (len > 0 && buf [len - 1] == '\n'){
			buf [len - 1] = 0;
			--len;
		}

		if (old_buf != buf)
			shquoted_buf = erealloc(shquoted_buf, size * 4 + 1);

		if ((size_t) -1 == shquote(buf, shquoted_buf, size * 4 + 1))
			errx(1, "shquote(3) failed: %s", strerror(errno));

		puts(shquoted_buf);
		old_buf = buf;
	}

	free(shquoted_buf);
	free(buf);

	return 0;
}
