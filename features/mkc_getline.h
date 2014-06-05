/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_GETLINE_H_
#define _MKC_GETLINE_H_

#include <stdio.h>
#include <stdlib.h>

#ifndef HAVE_FUNC3_GETLINE_STDIO_H
ssize_t getline(char** lineptr, size_t* n, FILE* stream);
#endif

#endif // _MKC_GETLINE_H_
