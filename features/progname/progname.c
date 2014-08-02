/*
 * Copyright (c) 2014 by Aleksey Cheusov
 * See LICENSE file in the distribution.
 */

#include <string.h>
#include <stdlib.h>
#include <errno.h>

#include <mkc_progname.h>

static const char *__prog = NULL;

const char * getprogname (void)
{
	if (__prog)
		return __prog;

#ifdef HAVE_FUNC0_GETEXECNAME_STDLIB_H
	/* SunOS */
	setprogname (getexecname ());
	return getprogname ();
#elif defined(HAVE_VAR_PROGRAM_INVOCATION_SHORT_NAME_ERRNO_H)
	return program_invocation_short_name;
#else
	return "<unset_progname>";
#endif
}

void setprogname (const char *progname)
{
	const char *s = strrchr (progname, '/');
	__prog = progname;

	if (s)
		__prog = s + 1;
}
