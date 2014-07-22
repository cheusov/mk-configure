/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_ERR_H_
#define _MKC_ERR_H_

#include <stdarg.h>

#if HAVE_HEADER_ERR_H
#include <err.h>
#endif

#ifdef MKC_ERR_IS_FINE

#include <err.h>

#else
#if !HAVE_FUNC3_ERR_ERR_H
void err (int, const char *, ...);
#endif
#if !HAVE_FUNC3_ERRX_ERR_H
void errx (int, const char *, ...);
#endif
#if !HAVE_FUNC3_VERR_ERR_H
void verr (int, const char *, va_list);
#endif
#if !HAVE_FUNC3_VERRX_ERR_H
void verrx (int, const char *, va_list);
#endif

#endif /* MKC_ERR_IS_FINE */

#endif // _MKC_ERR_H_
