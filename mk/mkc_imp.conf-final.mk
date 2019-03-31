# Copyright (c) 2014, Aleksey Cheusov <vle@gmx.net>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

# MKC_AUTO_* variables are for debugging purposes only
MKC_AUTO_CPPFLAGS :=	${MKC_AUTO_CPPFLAGS} ${MKC_CPPFLAGS}
MKC_AUTO_CFLAGS   :=	${MKC_AUTO_CFLAGS} ${MKC_CFLAGS}
MKC_AUTO_LDADD    :=	${MKC_AUTO_LDADD} ${MKC_LDADD}
MKC_AUTO_SRCS     :=	${MKC_AUTO_SRCS} ${MKC_SRCS}

.if !${MKC_NOAUTO:U0}
.for i in ${MKC_CPPFLAGS}
.  if !empty(CPPFLAGS:M${i})
CPPFLAGS +=	${i}
.  endif
.endfor
.for i in ${MKC_CFLAGS}
.  if !empty(CFLAGS:M${i})
CFLAGS +=	${i}
.  endif
.endfor
.for i in ${MKC_LDADD}
.  if !empty(LDADD:M${i})
LDADD +=	${i}
.  endif
.endfor
.if !${MKC_NOSRCSAUTO:U0}
.  for i in ${MKC_SRCS}
.    if !empty(SRCS:M${i})
SRCS +=		${i}
.    endif
.  endfor
.endif
.endif # .if MKC_AUTO

.undef MKC_CPPFLAGS
.undef MKC_CFLAGS
.undef MKC_LDADD
.undef MKC_SRCS
