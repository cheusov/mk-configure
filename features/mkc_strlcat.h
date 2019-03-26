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

#if !HAVE_FUNC3_STRLCAT_STRING_H
size_t strlcat(char *dst, const char *src, size_t size);
#endif

#endif // _MKC_STRLCAT_H_
