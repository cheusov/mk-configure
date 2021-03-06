/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_ERR_H_
#define _MKC_ERR_H_

#ifndef _MKC_CHECK_ERR
# error "Missing MKC_FEATURES += err"
#endif

#include <stdarg.h>

#if HAVE_HEADER_ERR_H
#include <err.h>
#endif

#ifdef MKC_ERR_IS_FINE

#include <err.h>

#else

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#include "mkc_macro.h"

#if !HAVE_FUNC3_ERR_ERR_H
void err (int, const char *, ...) __printflike(2, 3) __dead;
#endif
#if !HAVE_FUNC3_ERRX_ERR_H
void errx (int, const char *, ...) __printflike(2, 3) __dead;
#endif
#if !HAVE_FUNC3_VERR_ERR_H
void verr (int, const char *, va_list) __printflike(2, 0) __dead;
#endif
#if !HAVE_FUNC3_VERRX_ERR_H
void verrx (int, const char *, va_list) __printflike(2, 0) __dead;
#endif

__MKC_END_DECLS

#endif /* MKC_ERR_IS_FINE */

#endif // _MKC_ERR_H_
