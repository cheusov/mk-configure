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

#ifndef HAVE_FUNC4_GETDELIM_STDIO_H
ssize_t getdelim(char **lineptr, size_t *n, int delim, FILE *stream);
#endif

#endif // _MKC_GETDELIM_H_
