/*
 * Copyright (c) 2014 by Aleksey Cheusov
 * See LICENSE file in the distribution.
 */


/* 
  Rejected in glibc (http://sourceware.org/ml/libc-alpha/2006-03/msg00125.html)
*/

#include <string.h>

#include <mkc_progname.h>

static const char *__prog = NULL;

const char * getprogname (void)
{
//#if defined(HAVE_PROGRAM_INVOCATION_SHORT_NAME)
//	if (__progname == NULL)
//		__progname = program_invocation_short_name;
//#elif defined(HAVE_GETEXECNAME)
//	/* getexecname(3) returns an absolute pathname, normalize it. */
//	if (__progname == NULL)
//		setprogname(getexecname());
//#endif

	return __prog;
}

void setprogname (const char *progname)
{
	const char *s = strrchr (progname, '/');
	__prog = progname;

	if (s)
		__prog = s + 1;
}
