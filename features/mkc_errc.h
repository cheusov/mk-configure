/********************************************************************\
 Copyright (c) 2017 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_ERRC_H_
#define _MKC_ERRC_H_

#ifndef _MKC_CHECK_ERRC
# error "Missing MKC_FEATURES += errc"
#endif

#include <stdarg.h>

#if HAVE_HEADER_ERR_H
#include <err.h>
#endif

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#include "mkc_macro.h"

#if !HAVE_FUNC4_ERRC_ERR_H
void errc(int status, int code, const char *fmt, ...) __dead;
#endif

#if !HAVE_PROTOTYPE_VERRC
void verrc(int status, int code, const char *fmt, va_list args) __dead;
#endif

__MKC_END_DECLS

#endif // _MKC_ERRC_H_
