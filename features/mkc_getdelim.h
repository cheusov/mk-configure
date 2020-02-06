/********************************************************************\
 Copyright (c) 2020 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_GETDELIM_H_
#define _MKC_GETDELIM_H_

#ifndef _MKC_CHECK_GETDELIM
# error "Missing MKC_FEATURES += getdelim"
#endif

#include <stdio.h>
#include <stdlib.h>

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#ifndef HAVE_FUNC4_GETDELIM_STDIO_H
ssize_t getdelim(char **lineptr, size_t *n, int delim, FILE *stream);
#endif

__MKC_END_DECLS

#endif // _MKC_GETDELIM_H_
