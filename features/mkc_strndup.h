/********************************************************************\
 Copyright (c) 2020 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_STRNDUP_H_
#define _MKC_STRNDUP_H_

#ifndef _MKC_CHECK_STRNDUP
# error "Missing MKC_FEATURES += strndup"
#endif

#include <string.h>

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#if !HAVE_FUNC2_STRNDUP_STRING_H
char *strndup(const char *str, size_t n);
#endif

__MKC_END_DECLS

#endif // _MKC_STRNDUP_H_
