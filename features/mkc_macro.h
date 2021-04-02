/********************************************************************\
 Copyright (c) 2021 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_MACRO_H_
#define _MKC_MACRO_H_

#ifndef _MKC_CHECK_MACRO
# error "Missing MKC_FEATURES += macro"
#endif

#ifndef __aligned
#  ifdef HAVE_NO_ATTR_ALIGNED
#    define __aligned(x)
#  else
#    define __aligned(x) __attribute__((aligned(x)))
#  endif
#endif

#ifndef __always_inline
#  ifdef HAVE_NO_ATTR_ALWAYS_INLINE
#    define __always_inline
#  else
#    define __always_inline __attribute__((always_inline))
#  endif
#endif

#ifndef __constfunc
#  ifdef HAVE_NO_ATTR_CONST
#    define __constfunc
#  else
#    define __constfunc __attribute__((const))
#  endif
#endif

#ifndef __dead
#  ifdef HAVE_NO_ATTR_NORETURN
#    define __dead
#  else
#    define __dead __attribute__((noreturn))
#  endif
#endif

#ifndef __pure
#  ifdef HAVE_NO_ATTR_PURE
#    define __pure
#  else
#    define __pure __attribute__((pure))
#  endif
#endif

#ifndef __printflike
#  ifdef HAVE_NO_ATTR_PRINTFLIKE
#    define __printflike
#  else
#    define __printflike(fmtarg, firstvararg) \
	__attribute__((format (printf, fmtarg, firstvararg)))
#  endif
#endif

#ifndef _DIAGASSERT
#  define _DIAGASSERT(c) assert(c)
#endif

#ifndef __UNCONST
#  define __UNCONST(p) ((void *) ((char *)0 + ((const char *)(p) - (const char *)0)))
#endif

#endif /* _MKC_MACRO_H_ */
