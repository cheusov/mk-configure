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

MKHTML?=	no

######################################################################
.if !defined(NOMKC_DPLIBS) || empty(NOMKC_DEPLIBS:M[Yy][Ee][Ss])

.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir}
DPLIBDIRS.${_dir}	!= 	cd ${_dir} && ${MAKE} mkc_printobjdir
LDADD+=			-L${DPLIBDIRS.${_dir}}
.endif
.endfor

LDADD+=			${DPLIBS}

.endif # NOMKC_DPLIBS

######################################################################
.if !defined(NOMKC_PATHS) || empty(NOMKC_PATHS:M[Yy][Ee][Ss])
NOMKC_PATHS:=	yes

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
FILESDIR?=		${PREFIX}/bin
INFODIR?=		${PREFIX}/info
.endif # NOMKC_PATHS

######################################################################
.if !defined(NOMKC_PERMS) || empty(NOMKC_PERMS:M[Yy][Ee][Ss])
.if make(install)
NOMKC_PERMS:=	yes

# Default owner and group
_MKC_UID!=	id -u
_MKC_GID!=	id -g

.if ${_MKC_UID} != 0
_MKC_USER!=	id -un
_MKC_GROUP!=	id -gn

MANOWN?=	${_MKC_USER}
MANGRP?=	${_MKC_GROUP}

BINOWN?=	${_MKC_USER}
BINGRP?=	${_MKC_GROUP}

FILESOWN?=	${_MKC_USER}
FILESGRP?=	${_MKC_GROUP}

LIBOWN?=	${_MKC_USER}
LIBGRP?=	${_MKC_GROUP}

DOCOWN?=	${_MKC_USER}
DOCGRP?=	${_MKC_GROUP}

NLSOWN?=	${_MKC_USER}
NLSGRP?=	${_MKC_GROUP}

INFOOWN?=	${_MKC_USER}
INFOGRP?=	${_MKC_GROUP}

.endif

.endif # make(install)
.endif # NOMKC_PERMS

######################################################################
.if defined(MKC_NOBSDMK) && !empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
.include <own.mk>
.else
.include <bsd.own.mk>
.endif

######################################################################
.if !defined(NOMKC_INCS) || empty(NOMKC_INCS:M[Yy][Ee][Ss])
.if make(install)

NOMKC_INCS:=	yes

.if !defined(MKC_NOBSDMK) || empty(MKC_NOBSDMK:M[Yy][Ee][Ss])
realinstall : includes
.else
#.PHONY : mkc-install-includes
#install : mkc-install-includes
#	${INSTALL_DATA}
.endif

.endif # make(install)
.endif # NOMKC_INCS

######################################################################
.if !defined(NOMKC_INSTDIRS) || empty(NOMKC_INSTDIRS:M[Yy][Ee][Ss])
.if make(install-dirs)

NOMKC_INSTDIRS:=	yes

# install-dirs target

.if defined(INCS)
_MKC_INSTALLDIRS+=	${DESTDIR}${INCSDIR}
.endif

.if defined(PROG)
_MKC_INSTALLDIRS+=	${DESTDIR}${BINDIR}
.endif

.if defined(SCRIPTS)
_MKC_INSTALLDIRS+=	${DESTDIR}${BINDIR}
.endif

.if defined(FILES)
.for i in ${FILES}
.if defined(FILESDIR_${i})
_MKC_INSTALLDIRS+=	${DESTDIR}${FILESDIR_${i}}
.else
_MKC_INSTALLDIRS+=	${DESTDIR}${FILESDIR}
.endif
.endfor
.endif

.if defined(LIB)
_MKC_INSTALLDIRS+=	${DESTDIR}${LIBDIR}
.endif

.if defined(MAN)
.if defined(MKMAN) && !empty(MKMAN:M[Yy][Ee][Ss])
_MKC_INSTALLDIRS+=	${DESTDIR}${MANDIR}/man1
.if defined(MKCATPAGES) && !empty(MKCATPAGES:M[Yy][Ee][Ss])
_MKC_INSTALLDIRS+=	${DESTDIR}${MANDIR}/cat1
.endif # MKCATPAGES
.if defined(MKHTML) && !empty(MKHTML:M[Yy][Ee][Ss])
.for i in ${MAN:E:O:u}
_MKC_INSTALLDIRS+=	${DESTDIR}${MANDIR}/html${i}
.endfor
.endif # MKHTML
.endif # MKMAN
.endif # MAN

.if defined(TEXINFO)
.if !defined(MKINFO) || empty(MKINFO:M[Nn][Oo])
_MKC_INSTALLDIRS+=	${DESTDIR}${INFODIR}
.endif # MKINFO
.endif # TEXINFO

.PHONY: install-dirs
install-dirs:
.for d in ${_MKC_INSTALLDIRS:O:u}
	${INSTALL} -d "${d}"
.endfor

.endif # make(install-dirs)
.endif # NOMKC_INSTDIRS
######################################################################
.if !defined(NOMKC_UNINSTALL) || empty(NOMKC_UNINSTALL:M[Yy][Ee][Ss])
.if make(uninstall)

NOMKC_UNINSTALL:=	yes

# uninstall target

.if defined(INCS)
.for i in ${INCS}
_MKC_UNINSTALLFILES+=	${DESTDIR}${INCSDIR}/${i}
.endfor
.endif

.if defined(PROG)
_MKC_UNINSTALLFILES+=	${DESTDIR}${BINDIR}/${PROG}
.endif

.if defined(SCRIPTS)
.for i in ${SCRIPTS}
_MKC_UNINSTALLFILES+=	${DESTDIR}${BINDIR}/${i}
.endfor
.endif

.if defined(FILES)
.for i in ${FILES}
.if defined(FILESDIR_${i})
_MKC_UNINSTALLFILES+=	${DESTDIR}${FILESDIR_${i}}/${i}
.else
_MKC_UNINSTALLFILES+=	${DESTDIR}${FILESDIR}/${i}
.endif
.endfor
.endif

.if defined(LIB)
_MKC_UNINSTALLFILES+=	${DESTDIR}${LIBDIR}/${LIB}
.endif

.if defined(MAN)
.if defined(MKMAN) && !empty(MKMAN:M[Yy][Ee][Ss])
#_MKC_MANCTGRS=		${MAN:E:O:u}
.for i in ${MAN}
_MKC_UNINSTALLFILES+=	${DESTDIR}${MANDIR}/man${i:E}/${i}
.if defined(MKCATPAGES) && !empty(MKCATPAGES:M[Yy][Ee][Ss])
_MKC_UNINSTALLFILES+=	${DESTDIR}${MANDIR}/cat${i:E}/${i:R}.cat${i:E}
.endif # MKCATPAGES
.if defined(MKHTML) && !empty(MKHTML:M[Yy][Ee][Ss])
_MKC_UNINSTALLFILES+=	${DESTDIR}${MANDIR}/html${i}/${i:R}.html${i:E}
.endif # MKHTML
.endfor # i
.endif # MKMAN
.endif # MAN

.if defined(TEXINFO)
.if !defined(MKINFO) || empty(MKINFO:M[Nn][Oo])
.for i in ${TEXINFO}
_MKC_UNINSTALLFILES+=	${DESTDIR}${INFODIR}/${i}
.endfor
.endif # MKINFO
.endif # TEXINFO

.PHONY: uninstall
uninstall:
	rm -f ${_MKC_UNINSTALLFILES}

.endif # make(uninstall)
.endif # NOMKC_UNINSTALL
######################################################################
# general purpose targets
.if !defined(NOMKC_TARGETS) || empty(NOMKC_TARGETS:M[Yy][Ee][Ss])
NOMKC_TARGETS:=        yes

###########

.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

###########
.PHONY : mkc_printobjdir
mkc_printobjdir:
	@echo ${.OBJDIR}

###########
.PHONY : test all distclean

###########
.ifndef SUBDIR # skip the following for mkc.subdir.mk
###########

test: all

###########

distclean: clean
distclean:
	rm -f ${DISTCLEANFILES}

###########

all : error-check # ${.OBJDIR}/.error-check
#${.OBJDIR}/.error-check:
error-check:
	@if test -n "${MKC_ERR_MSG}"; then \
		echo ${MKC_ERR_MSG}; exit 1; \
	fi
.endif # SUBDIR
#######################################
.endif # NOMKC_TARGETS
######################################################################

.if !defined(SRCS)
.if defined(PROG)
SRCS+=	${PROG}.c
.elif defined(LIB)
SRCS+=	${LIB}.c
.endif
.endif

.if !defined(MAN)
.if defined(PROG)
MAN+=	${PROG}.1
.endif
.endif

######################################################################

.for i in ${MAN}
CLEANFILES+=	${i:R}.cat${i:E}
.endfor

######################################################################

.endif # NOMKC_ATALL
