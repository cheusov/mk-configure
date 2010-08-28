# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.if !defined(_BSD_OWN_MK_)
_BSD_OWN_MK_=1

.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif defined(MKC_SYSCONFDIR) && exists(${MKC_SYSCONFDIR}/mk.conf)
.include "${MKC_SYSCONFDIR}/mk.conf"
.elif exists(/etc/mk.conf)
.include "/etc/mk.conf"
.endif

.if ${OPSYS:Ux} == "SunOS"
_MKC_USER!=	/usr/xpg4/bin/id -un
_MKC_GROUP!=	/usr/xpg4/bin/id -gn
.else
_MKC_USER!=	id -un
_MKC_GROUP!=	id -gn
.endif

.if ${_MKC_USER} != root
ROOT_USER?=	${_MKC_USER}
ROOT_GROUP?=	${_MKC_GROUP}
.endif

.include <mkc_imp.sys.mk>

# Define MANZ to have the man pages compressed (gzip)
#MANZ=		1

PREFIX?=	/usr/local

BINDIR?=	${PREFIX}/bin
SBINDIR?=	${PREFIX}/sbin
FILESDIR?=	${PREFIX}/bin
LIBEXECDIR?=	${PREFIX}/libexec
INCSDIR?=	${PREFIX}/include
DATADIR?=	${PREFIX}/share
SYSCONFDIR?=	${PREFIX}/etc
INFODIR?=	${PREFIX}/info
MANDIR?=	${PREFIX}/man
LIBDIR?=	${PREFIX}/lib
SCRIPTSDIR?=	${BINDIR}

DOCDIR?=	${DATADIR}/doc
HTMLDOCDIR?=	${DOCDIR}/html
HTMLDIR?=	${MANDIR}

BINGRP?=	${ROOT_GROUP}
BINOWN?=	${ROOT_USER}
BINMODE?=	555
NONBINMODE?=	444

MANGRP?=	${ROOT_GROUP}
MANOWN?=	${ROOT_USER}
MANMODE?=	${NONBINMODE}
MANINSTALL?=	maninstall catinstall

INFOGRP?=	${ROOT_GROUP}
INFOOWN?=	${ROOT_USER}
INFOMODE?=	${NONBINMODE}

LIBGRP?=	${BINGRP}
LIBOWN?=	${BINOWN}
LIBMODE?=	${NONBINMODE}

DOCGRP?=	${ROOT_GROUP}
DOCOWN?=	${ROOT_USER}
DOCMODE?=	${NONBINMODE}

FILESOWN?=	${BINOWN}
FILESGRP?=	${BINGRP}
FILESMODE?=	${NONBINMODE}

SCRIPTSOWN?=	${BINOWN}
SCRIPTSGRP?=	${BINGRP}
SCRIPTSMODE?=	${BINMODE}

COPY?=		-c
PRESERVE?=
STRIPFLAG?=	-s

.PHONY:		${TARGETS}

install:	realinstall
subdir-install:
realinstall:

all:		realall
subdir-all:
realall:

distclean:	cleandir

PRINTOBJDIR=	printf "xxx: .MAKE\n\t@echo \$${.OBJDIR}\n" | ${MAKE} -B -s -f-

MKINSTALL?=yes

MKCATPAGES?=no
MKHTML?=no
MKDOC?=yes
MKINFO?=yes
MKMAN?=yes

#
# MKOBJDIRS controls whether object dirs are created during "make build".
# MKOBJ controls whether the "make obj" rule does anything.
#
MKOBJ?=yes
MKOBJDIRS?=no

MKSHARE?=yes

MKDLL?=		no
.if ${MKDLL:tl} == "only"
MKDLL=		yes
MKSTATICLIB?=	no
.else
MKSTATICLIB?=	yes
.endif # MKDLL

.if ${MKDLL:tl} != "no"
SHLIB_MAJOR=	1
SHLIB_MINOR=	0
.endif # MKDLL

.if defined(SHLIB_MAJOR)
MKSHLIB?=	yes
.else
MKSHLIB?=	no
.endif # SHLIB_MAJOR

MKPICLIB?=	no
MKPROFILELIB?=	no

MKINSTALLDIRS?=	yes

EXPORT_VARNAMES+=	MKC_CACHEDIR

.endif		# _BSD_OWN_MK_
