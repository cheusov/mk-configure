/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_STRLCAT_H_
#define _MKC_STRLCAT_H_

#ifndef _MKC_CHECK_STRLCAT
# error "Missing MKC_FEATURES += strlcat"
#endif

#include <string.h>

#include "mkc_externc.h"

#if !HAVE_FUNC3_STRLCAT_STRING_H
__MKC_BEGIN_DECLS
size_t strlcat(char *dst, const char *src, size_t size);
__MKC_END_DECLS
#endif

#endif // _MKC_STRLCAT_H_
