#include <stdio.h>

#include "mkc_strlcat.h"
#include "mkc_strlcpy.h"
#include "mkc_getline.h"
#include "mkc_progname.h"
#include "mkc_fgetln.h"
#include "mkc_err.h"
#include "mkc_warn.h"
#include "mkc_libm.h"
#include "mkc_getdelim.h"
#include "mkc_strndup.h"
#include "mkc_libdl.h"
#include "mkc_RB.h"
#include "mkc_SPLAY.h"
#include "mkc_SLIST.h"
#include "mkc_SIMPLEQ.h"
#include "mkc_STAILQ.h"
#include "mkc_LIST.h"
#include "mkc_TAILQ.h"
#include "mkc_CIRCLEQ.h"

int main(int argc, char** argv)
{
	char buffer[100];
	char *line = NULL;
	size_t line_size = 0;

	strlcpy(buffer, "foo", sizeof(buffer));
	strlcat(buffer, "bar", sizeof(buffer));
	getline(&line, &line_size, stdin);
	getdelim(&line, &line_size, '\0', stdin);
	getprogname();
	setprogname("baz");
	fgetln(stdin, &line_size);
	err(0, "error: %s", "error");
	errx(0, "error: %s", "error");
	strndup("foo", 10);

	return 0;
}
