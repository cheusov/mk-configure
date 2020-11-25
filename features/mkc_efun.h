/*-
 * Copyright (c) 2016-2017 Aleksey Cheusov <vle@gmx.net>
 * Copyright (c) 1995
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
 */

#ifndef _MKC_EFUN_H_
#define _MKC_EFUN_H_

#ifndef _MKC_CHECK_EFUN
# error "Missing MKC_FEATURES += efun"
#endif

#if defined(HAVE_FUNC2_ECALLOC_UTIL_H)
#  include <util.h>
#else

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#  include <stdarg.h>
#  include <stdint.h>
#  include <stdio.h>

#  include <mkc_externc.h>

__MKC_BEGIN_DECLS

void (*esetfunc(void (*)(int, const char *, ...))) (int, const char *, ...);

int easprintf(char ** /*restrict*/ str, const char * /*restrict*/ fmt, ...);

FILE * efopen(const char *p, const char *m);

void * ecalloc(size_t n, size_t c);

void * emalloc(size_t n);

void * erealloc(void *p, size_t n);

//void ereallocarr(void *, size_t, size_t);

char * estrdup(const char *s);

char * estrndup(const char *s, size_t len);

size_t estrlcat(char *dst, const char *src, size_t len);

size_t estrlcpy(char *dst, const char *src, size_t len);

int evasprintf(char ** /*__restrict*/ str, const char * /*__restrict*/ fmt, va_list ap);

__MKC_END_DECLS

#  endif

#endif /* _MKC_EFUN_H_ */
