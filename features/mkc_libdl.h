/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_LIBDL_H_
#define _MKC_LIBDL_H_

#ifndef _GNU_SOURCE
#   define _GNU_SOURCE
#   include <dlfcn.h>
#   undef _GNU_SOURCE
#else
#   include <dlfcn.h>
#endif

#endif // _MKC_LIBDL_H_
