/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_GETLINE_H_
#define _MKC_GETLINE_H_

#ifndef _MKC_CHECK_GETLINE
# error "Missing MKC_FEATURES += getline"
#endif

#include <stdio.h>
#include <stdlib.h>

#include "mkc_externc.h"

#ifndef HAVE_FUNC3_GETLINE_STDIO_H
__MKC_BEGIN_DECLS
ssize_t getline(char** lineptr, size_t* n, FILE* stream);
__MKC_END_DECLS
#endif

#endif // _MKC_GETLINE_H_
