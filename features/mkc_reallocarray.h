/********************************************************************\
 Copyright (c) 2017 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_REALLOCARRAY_H_
#define _MKC_REALLOCARRAY_H_

#ifndef _MKC_CHECK_REALLOCARRAY
# error "Missing MKC_FEATURES += reallocarray"
#endif

#include <stdio.h>

#ifndef HAVE_FUNC3_REALLOCARRAY_STDIO_H
#include <mkc_externc.h>
__MKC_BEGIN_DECLS
void *reallocarray(void *ptr, size_t nmemb, size_t size);
__MKC_END_DECLS
#endif

#endif // _MKC_REALLOCARRAY_H_
