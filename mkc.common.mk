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
FILES?=			${PREFIX}/bin
.endif # NOMKC_PATHS

######################################################################
.if !defined(NOMKC_PERMS) || empty(NOMKC_PERMS:M[Yy][Ee][Ss])
# Default owner and group
_MKC_UID!=	id -u
_MKC_GID!=	id -g

.if ${_MKC_UID} != 0
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
.endif

.endif # NOMKC_PERMS

######################################################################
.if !defined(NOMKC_DPLIBS) || empty(NOMKC_DEPLIBS:M[Yy][Ee][Ss])

mkc_printobjdir:
	@echo ${.OBJDIR}

.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir}
DPLIBDIRS.${_dir}	!= 	cd ${_dir} && ${MAKE} mkc_printobjdir
LDFLAGS+=			-L${DPLIBDIRS.${_dir}}
.endif
.endfor

.endif # NOMKC_DPLIBS

######################################################################
.if !defined(NOMKC_INCS) || empty(NOMKC_INCS:M[Yy][Ee][Ss])

.if defined(MKC_NOBSDMK) && !empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
realinstall : includes
.else
#.PHONY : mkc-install-includes
#install : mkc-install-includes
#	${INSTALL_DATA}
.endif

.endif # NOMKC_INCS

######################################################################

# install-dirs target

.ifdef INCS
INSTALLDIRS+=	${DESTDIR}${INCSDIR}
.endif

.ifdef PROG
INSTALLDIRS+=	${DESTDIR}${BINDIR}
.endif

.ifdef SCRIPTS
INSTALLDIRS+=	${DESTDIR}${BINDIR}
.endif

.ifdef FILES
INSTALLDIRS+=	${DESTDIR}${FILESDIR}
.endif

.ifdef LIB
INSTALLDIRS+=	${DESTDIR}${LIBDIR}
.endif

.if defined(MAN)
.if !defined(MKMAN) || empty(MKMAN:M[Nn][Oo])
.if !defined(NOMAN) || empty(NOMAN:M[Yy][Ee][Ss])
INSTALLDIRS+=	${DESTDIR}${MANDIR}/man1
.if !defined(MKCATPAGES) || empty(MKCATPAGES:M[Nn][Oo])
INSTALLDIRS+=	${DESTDIR}${MANDIR}/cat1
.endif
.endif
.endif
.endif

.PHONY: install-dirs
install-dirs:
.for d in ${INSTALLDIRS}
	${INSTALL} -d ${d}
.endfor

######################################################################

.endif # NOMKC_ATALL
