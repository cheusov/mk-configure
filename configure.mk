# Copyright (c) 2009, Aleksey Cheusov <vle@gmx.net>
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

.include <bsd.own.mk>

CACHE_DIR=${.OBJDIR}

# checking for headers
.for h in ${AC_CHECK_HEADERS}
HAVE.${h:S|/|_|g}!=	env CC=${CC} LDFLAGS=${LDFLAGS} LDADD=${LDADD} CACHE_DIR=${CACHE_DIR} ../mk-configure/mk-configure_check_header ${h}
CFLAGS+=	-DHAVE_${h:tu:S|.|_|g:S|/|_|g}=${HAVE.${h:S|/|_|g}}
.endfor

# checking for functions in libraries
.for f in ${AC_CHECK_FUNCS}
HAVE.${f:S|-l||g:S| |_|g:S/|/_/g}!=	env CC=${CC} LDFLAGS=${LDFLAGS} LDADD=${LDADD} CACHE_DIR=${CACHE_DIR} ../mk-configure/mk-configure_check_funcs ${f:S/|/ /g}
CFLAGS+=	-DHAVE.${f:S|-l||g:S| |_|g:S/|/_/g}=${HAVE.${f:S|-l||g:S| |_|g:S/|/_/g}}
.endfor
