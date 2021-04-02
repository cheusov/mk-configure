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

#ifdef HAVE_NO_ATTR_PURE
# define __pure
#else
# define __pure __attribute__((pure))
#endif

#ifdef HAVE_NO_ATTR_CONST
# define __constfunc
#else
# define __constfunc __attribute__((const))
#endif

#ifdef HAVE_NO_ATTR_PRINTFLIKE
# define __printflike
#else
# define __printflike(fmtarg, firstvararg) \
	__attribute__((format (printf, fmtarg, firstvararg)))
#endif

#ifndef _DIAGASSERT
#define _DIAGASSERT(c) assert(c)
#endif

#ifndef __UNCONST
#define __UNCONST(p) ((void *) ((char *)0 + ((const char *)(p) - (const char *)0)))
#endif

#endif /* _MKC_MACRO_H_ */
