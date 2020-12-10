/*
 * Copyright © 2020 Aleksey Cheusov <vle@gmx.net>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _MKC_HUMANIZE_NUMBER_H_
#define _MKC_HUMANIZE_NUMBER_H_

#ifndef _MKC_CHECK_HUMANIZE_NUMBER
# error "Missing MKC_FEATURES += humanize_number"
#endif

#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>

#ifndef HN_DECIMAL
#define   HN_DECIMAL              0x01
#define   HN_NOSPACE              0x02
#define   HN_B                    0x04
#define   HN_DIVISOR_1000         0x08

#define   HN_GETSCALE             0x10
#define   HN_AUTOSCALE            0x20
#endif

#include "mkc_externc.h"

#ifndef HAVE_FUNC6_HUMANIZE_NUMBER_STDLIB_H
__MKC_BEGIN_DECLS
int humanize_number(char *buf, size_t len, int64_t bytes,
					const char *suffix, int scale, int flags);
__MKC_END_DECLS
#endif

#ifndef HAVE_FUNC2_DEHUMANIZE_NUMBER_STDLIB_H
__MKC_BEGIN_DECLS
int dehumanize_number(const char *str, int64_t *result);
__MKC_END_DECLS
#endif

#endif // _MKC_HUMANIZE_NUMBER_H_
