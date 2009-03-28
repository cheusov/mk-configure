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

######################################################################
.if !defined(NOMKC_ATALL) || empty(NOMKC_ATALL:M[Yy][Ee][Ss])

######################################################################
.if !defined(NOMKC_PATHS) || empty(NOMKC_PATHS:M[Yy][Ee][Ss])
# Default PATHs
PREFIX?=		/usr/local
BINDIR?=		${PREFIX}/bin
SBINDIR?=		${PREFIX}/sbin
MANDIR?=		${PREFIX}/man
LIBDIR?=		${PREFIX}/lib
LIBEXECDIR?=		${PREFIX}/libexec
INCSDIR?=		${PREFIX}/include
DATADIR?=		${PREFIX}/share
SYSCONFDIR?=		${PREFIX}/etc
.endif # NOMKC_PATHS

######################################################################
.if !defined(NOMKC_PERMS) || empty(NOMKC_PERMS:M[Yy][Ee][Ss])
# Default owner and group
_MKC_UID!=	id -u
_MKC_GID!=	id -g

MANOWN?=	${_MKC_UID}
MANGRP?=	${_MKC_GID}

BINOWN?=	${_MKC_UID}
BINGRP?=	${_MKC_GID}

FILESOWN?=	${_MKC_UID}
FILESGRP?=	${_MKC_GID}

LIBOWN?=	${_MKC_UID}
LIBGRP?=	${_MKC_GID}

DOCOWN?=	${_MKC_UID}
DOCGRP?=	${_MKC_GID}

NLSOWN?=	${_MKC_UID}
NLSGRP?=	${_MKC_GID}
.endif # NOMKC_PERMS

######################################################################
.if !defined(NOMKC_DEPLIBS) || empty(NOMKC_DEPLIBS:M[Yy][Ee][Ss])

mkc_printdpdata:
	@echo ${.OBJDIR} ${SHLIB_MAJOR:?.so:.a}

.for _lib _dir in ${MKCDPLIBS}
MKCDPDATA.${_lib}!= cd ${_dir} && ${MAKE} mkc_printdpdata
LDADD+=		-L${MKCDPDATA.${_lib}:[1]} -l${_lib}
DPADD+=		${MKCDPDATA.${_lib}:[1]}/lib${_lib}${MKCDPDATA.${_lib}:[2]}
.endfor

.endif # NOMKC_DEPLIBS

######################################################################
.endif # NOMKC_ATALL
