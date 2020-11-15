/********************************************************************\
 Copyright (c) 2018 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_DPRINTF_H_
#define _MKC_DPRINTF_H_

#ifndef _MKC_CHECK_DPRINTF
# error "Missing MKC_FEATURES += dprintf"
#endif

#include <stdio.h>
#include <stdarg.h>
#include <mkc_externc.h>

__MKC_BEGIN_DECLS

#if !HAVE_FUNC3_DPRINTF_STDIO_H
int dprintf(int fd, const char * /*__restrict*/ format, ...);
#endif

#if !HAVE_FUNC4_VDPRINTF_STDIO_H
int vdprintf(int fd, const char * /*__restrict*/ format, va_list ap);
#endif

__MKC_END_DECLS

#endif // _MKC_DPRINTF_H_
