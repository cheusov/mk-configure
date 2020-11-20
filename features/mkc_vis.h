/*	$NetBSD: vis.h,v 1.21 2013/02/20 17:01:15 christos Exp $	*/

/*-
 * Copyright (c) 1990, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *	@(#)vis.h	8.1 (Berkeley) 6/2/93
 */

#ifndef _MKC_VIS_H_
#define _MKC_VIS_H_

#ifndef _MKC_CHECK_VIS
# error "Missing MKC_FEATURES += vis"
#endif

#if HAVE_HEADER_FILE_VIS_H && HAVE_VIS
# include <stdlib.h> /* for OpenBSD-5.3 */
# include <vis.h>
#else

#include <sys/types.h>

/*
 * to select alternate encoding format
 */
#define	VIS_OCTAL	0x0001	/* use octal \ddd format */
#define	VIS_CSTYLE	0x0002	/* use \[nrft0..] where appropiate */

/*
 * to alter set of characters encoded (default is to encode all
 * non-graphic except space, tab, and newline).
 */
#define	VIS_SP		0x0004	/* also encode space */
#define	VIS_TAB		0x0008	/* also encode tab */
#define	VIS_NL		0x0010	/* also encode newline */
#define	VIS_WHITE	(VIS_SP | VIS_TAB | VIS_NL)
#define	VIS_SAFE	0x0020	/* only encode "unsafe" characters */

/*
 * other
 */
#define	VIS_NOSLASH	0x0040	/* inhibit printing '\' */
#define	VIS_HTTP1808	0x0080	/* http-style escape % hex hex */
#define	VIS_HTTPSTYLE	0x0080	/* http-style escape % hex hex */
#define	VIS_MIMESTYLE	0x0100	/* mime-style escape = HEX HEX */
#define	VIS_HTTP1866	0x0200	/* http-style &#num; or &string; */
#define	VIS_NOESCAPE	0x0400	/* don't decode `\' */
#define	_VIS_END	0x0800	/* for unvis */
#define	VIS_GLOB	0x1000	/* encode glob(3) magic characters */

/*
 * unvis return codes
 */
#define	UNVIS_VALID	 1	/* character valid */
#define	UNVIS_VALIDPUSH	 2	/* character valid, push back passed char */
#define	UNVIS_NOCHAR	 3	/* valid sequence, no character produced */
#define	UNVIS_SYNBAD	-1	/* unrecognized escape sequence */
#define	UNVIS_ERROR	-2	/* decoder in unknown state (unrecoverable) */

/*
 * unvis flags
 */
#define	UNVIS_END	_VIS_END	/* no more characters */

#endif /* HAVE_HEADER_FILE_VIS_H */

#include "mkc_externc.h"

__MKC_BEGIN_DECLS

#if !HAVE_FUNC4_VIS_VIS_H
char	*vis(char *, int, int, int);
#endif
#if !HAVE_FUNC5_NVIS_VIS_H
char	*nvis(char *, size_t, int, int, int);
#endif

#if !HAVE_FUNC5_SVIS_VIS_H
char	*svis(char *, int, int, int, const char *);
#endif
#if !HAVE_FUNC6_SNVIS_VIS_H
char	*snvis(char *, size_t, int, int, int, const char *);
#endif

#if !HAVE_FUNC3_STRVIS_VIS_H
int	strvis(char *, const char *, int);
#endif
#ifdef __OpenBSD__
int	_strnvis(char *, size_t, const char *, int);
#define strnvis(a,b,c,d) _strnvis(a,b,c,d)
#elif !HAVE_FUNC4_STRNVIS_VIS_H
int	strnvis(char *, size_t, const char *, int);
#endif

#if !HAVE_FUNC4_STRSVIS_VIS_H
int	strsvis(char *, const char *, int, const char *);
#endif
#if !HAVE_FUNC5_STRSNVIS_VIS_H
int	strsnvis(char *, size_t, const char *, int, const char *);
#endif

#if !HAVE_FUNC4_STRVISX_VIS_H
int	strvisx(char *, const char *, size_t, int);
#endif
#if !HAVE_FUNC5_STRNVISX_VIS_H
int	strnvisx(char *, size_t, const char *, size_t, int);
#endif
#if !HAVE_FUNC6_STRENVISX_VIS_H
int strenvisx(char *, size_t, const char *, size_t, int, int *);
#endif

#if !HAVE_FUNC5_STRSVISX_VIS_H
int	strsvisx(char *, const char *, size_t, int, const char *);
#endif
#if !HAVE_FUNC6_STRSNVISX_VIS_H
int	strsnvisx(char *, size_t, const char *, size_t, int, const char *);
#endif
#if !HAVE_FUNC7_STRSENVISX_VIS_H
int	strsenvisx(char *, size_t, const char *, size_t, int, const char *, int *);
#endif

#if !HAVE_FUNC2_STRUNVIS_VIS_H
int	strunvis(char *, const char *);
#endif
#ifdef __OpenBSD__
int	_strnunvis(char *, size_t, const char *);
#define strnunvis(a,b,c) _strnunvis(a,b,c)
#elif !HAVE_FUNC3_STRNUNVIS_VIS_H
int	strnunvis(char *, size_t, const char *);
#endif

#if !HAVE_FUNC3_STRUNVISX_VIS_H
int	strunvisx(char *, const char *, int);
#endif
#if !HAVE_FUNC4_STRNUNVISX_VIS_H
int	strnunvisx(char *, size_t, const char *, int);
#endif

#ifdef __OpenBSD__
int	_unvis(char *, int, int *, int);
#define unvis(a,b,c,d) _unvis(a,b,c,d)
#elif !HAVE_FUNC4_UNVIS_VIS_H
int	unvis(char *, int, int *, int);
#endif

__MKC_END_DECLS

#endif /* _MKC_VIS_H_ */
