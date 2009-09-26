#	$NetBSD: bsd.own.mk.in,v 1.2 2007/08/25 09:33:57 rillig Exp $

.if !defined(_BSD_OWN_MK_)
_BSD_OWN_MK_=1

.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif exists(@SYSCONFDIR@/mk.conf)
.include "@SYSCONFDIR@/mk.conf"
.elif exists(/etc/mk.conf)
.include "/etc/mk.conf"
.endif

_MKC_USER!=	id -un
_MKC_GROUP!=	id -gn

.if ${_MKC_USER} != root
ROOT_USER?=	${_MKC_USER}
ROOT_GROUP?=	${_MKC_GROUP}
.endif

.include <mkc_bsd.sys.mk>
.sinclude <mkc_bsd.${OPSYS}.own.mk>

OBJECT_FMT?=	ELF

ROOT_USER?=	root
ROOT_GROUP?=	wheel

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

FILESOWN?=${BINOWN}
FILESGRP?=${BINGRP}
FILESMODE?=${NONBINMODE}

COPY?=		-c
PRESERVE?=
STRIPFLAG?=	-s


TARGETS+=	all clean cleandir depend dependall includes \
		install lint obj regress tags html installhtml cleanhtml
.PHONY:		all clean cleandir depend dependall distclean includes \
		install lint obj regress tags beforedepend afterdepend \
		beforeinstall afterinstall realinstall realdepend realall \
		html installhtml cheanhtml

.if !target(install)
install:	.NOTMAIN beforeinstall subdir-install realinstall afterinstall
beforeinstall:	.NOTMAIN
subdir-install:	.NOTMAIN beforeinstall
realinstall:	.NOTMAIN beforeinstall
afterinstall:	.NOTMAIN subdir-install realinstall
.endif
all:		.NOTMAIN realall subdir-all
subdir-all:	.NOTMAIN
realall:	.NOTMAIN
depend:		.NOTMAIN realdepend subdir-depend
subdir-depend:	.NOTMAIN
realdepend:	.NOTMAIN
distclean:	.NOTMAIN cleandir

PRINTOBJDIR=	printf "xxx: .MAKE\n\t@echo \$${.OBJDIR}\n" | ${MAKE} -B -s -f-

# Define MKxxx variables (which are either yes or no) for users
# to set in /etc/mk.conf and override on the make commandline.
# These should be tested with `== "no"' or `!= "no"'.
# The NOxxx variables should only be used by Makefiles.
#

MKCATPAGES?=no

.if defined(NODOC)
MKDOC=no
.else
MKDOC?=yes
.endif

MKINFO?=yes

MKLINT?=no

.if defined(NOMAN)
MKMAN=no
.else
MKMAN?=yes
.endif
.if ${MKMAN} == "no"
MKCATPAGES=no
.endif

#
# MKOBJDIRS controls whether object dirs are created during "make build".
# MKOBJ controls whether the "make obj" rule does anything.
#
.if defined(NOOBJ)
MKOBJ=no
MKOBJDIRS=no
.else
MKOBJ?=yes
MKOBJDIRS?=no
.endif

.if defined(NOPIC)
MKPIC=no
.else
MKPIC?=yes
.endif

MKPICINSTALL?=no

MKPROFILE?=no

.if defined(NOSHARE)
MKSHARE=no
.else
MKSHARE?=yes
.endif
.if ${MKSHARE} == "no"
MKCATPAGES=no
MKDOC=no
MKINFO=no
MKMAN=no
.endif

.endif		# _BSD_OWN_MK_
