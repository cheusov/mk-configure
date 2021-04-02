/********************************************************************\
 Copyright (c) 2020 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_SHQUOTE_H_
#define _MKC_SHQUOTE_H_

#ifndef _MKC_CHECK_SHQUOTE
# error "Missing MKC_FEATURES += shquote"
#endif

#include <stdlib.h>

#include "mkc_externc.h"

#ifndef HAVE_FUNC3_SHQUOTE_STDLIB_H
__MKC_BEGIN_DECLS

#include "mkc_macro.h"

size_t shquote (const char *arg, char *buf, size_t bufsize) __constfunc;

__MKC_END_DECLS
#endif

#endif // _MKC_SHQUOTE_H_
