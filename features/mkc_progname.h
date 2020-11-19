/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_PROGNAME_H_
#define _MKC_PROGNAME_H_

#ifndef _MKC_CHECK_PROGNAME
# error "Missing MKC_FEATURES += progname"
#endif

#include <stdlib.h>

#else

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#if !HAVE_FUNC1_SETPROGNAME_STDLIB_H
void setprogname (const char *progname);
#endif

#if !HAVE_FUNC0_GETPROGNAME_STDLIB_H
const char * getprogname (void);
#endif

__MKC_END_DECLS

#endif // _MKC_PROGNAME_H_
