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

#include "mkc_externc.h"

#if !HAVE_FUNC3_STRLCPY_STRING_H
__MKC_BEGIN_DECLS
size_t strlcpy(char *dst, const char *src, size_t size);
__MKC_END_DECLS
#endif

#endif // _MKC_STRLCPY_H_
