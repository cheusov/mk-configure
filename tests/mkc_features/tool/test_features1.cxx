#include <stdio.h>

#include "mkc_arc4random.h"
#include "mkc_strlcat.h"
#include "mkc_strlcpy.h"
#include "mkc_getline.h"
#include "mkc_progname.h"
#include "mkc_fgetln.h"
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
#include "mkc_bswap.h"
#include "mkc_dprintf.h"
#include "mkc_efun.h"
#include "mkc_strsep.h"
#include "mkc_posix_getopt.h"
#include "mkc_raise_default_signal.h"
#include "mkc_reallocarray.h"
#include "mkc_fparseln.h"
#include "mkc_vis.h"
#include "mkc_fts.h"

int main(int argc, char** argv)
{
	char buffer[100];
	char *line = NULL;
	size_t line_size = 0;
	char *ptr = NULL;

	strlcpy(buffer, "foo", sizeof(buffer));
	strlcat(buffer, "bar", sizeof(buffer));
	getline(&line, &line_size, stdin);
	getdelim(&line, &line_size, '\0', stdin);
	getprogname();
	setprogname("baz");
	fgetln(stdin, &line_size);
	strndup("foo", 10);
	arc4random();
	bswap16(1);
	bswap32(1);
	bswap64(1);
	dprintf(2, "lalala\n");
	emalloc(100);
	erealloc(NULL, 200);
	ecalloc(100, 1);
	efopen("/path", "r");
	estrdup("papa");
	estrndup("papa", 5);
	estrlcat(buffer, "papa", sizeof(buffer));
	estrlcpy(buffer, "papa", sizeof(buffer));
	easprintf(&ptr, "%s", "papa");
	strsep(NULL, "\0");
	stresep(NULL, " \t", '\0');;
	free(ptr);
	getopt(0, NULL, NULL);
	raise_default_signal(15);
	reallocarray(NULL, 0, 0);
	fparseln(NULL, NULL, NULL, "\\\\#", 0);
	vis(NULL, 0, 0, 0);
	nvis(NULL, 0, 0, 0, 0);
	svis(NULL, 0, 0, 0, NULL);
	snvis(NULL, 0, 0, 0, 0, NULL);
	strvis(NULL, NULL, 0);
	strnvis(NULL, 0, NULL, 0);
	strsvis(NULL, NULL, 0, NULL);
	strsnvis(NULL, 0, NULL, 0, NULL);
	strvisx(NULL, NULL, 0, 0);
	strnvisx(NULL, 0, NULL, 0, 0);
	strenvisx(NULL, 0, NULL, 0, 0, NULL);
	strsvisx(NULL, NULL, 0, 0, NULL);
	strsnvisx(NULL, 0, NULL, 0, 0, NULL);
	strsenvisx(NULL, 0, NULL, 0, 0, NULL, NULL);
	strunvis(NULL, NULL);
	strnunvis(NULL, 0, NULL);
	strunvisx(NULL, NULL, 0);
	strnunvisx(NULL, 0, NULL, 0);
	unvis(NULL, 0, NULL, 0);
	fts_read(NULL);

	return 0;
}
