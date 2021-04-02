/********************************************************************\
 Copyright (c) 2021 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_MACRO_H_
#define _MKC_MACRO_H_

#ifndef _MKC_CHECK_MACRO
# error "Missing MKC_FEATURES += macro"
#endif

#ifdef HAVE_NO_ATTR_NORETURN
# define __dead
#else
# define __dead __attribute__((noreturn))
#endif

#ifndef _DIAGASSERT
#define _DIAGASSERT(c) assert(c)
#endif

#endif
