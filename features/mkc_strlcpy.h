/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_STRLCPY_H_
#define _MKC_STRLCPY_H_

#ifndef _MKC_CHECK_STRLCPY
# error "Missing MKC_FEATURES += strlcpy"
#endif

#include <string.h>

#if !HAVE_FUNC3_STRLCPY_STRING_H
size_t strlcpy(char *dst, const char *src, size_t size);
#endif

#endif // _MKC_STRLCPY_H_
