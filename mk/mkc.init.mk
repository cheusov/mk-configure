# Copyright (c) 2009-2014 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
# Copyright (c) 2009-2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef OPSYS
OPSYS !=	uname -s
OPSYS :=	${OPSYS:C/^CYGWIN.*$/Cygwin/}
.endif
TARGET_OPSYS ?=	${OPSYS}

###########
SHORTPRJNAME   ?=	yes

######################################################################
.ifndef __initialized__
__initialized__ := 1

.include "mkc_imp.preinit.mk"

.MAIN:		all

###########

.for p in ${PROGS}
SRCS.${p} ?=	${p}.c
SRCS.${p} +=	${SRCS} # SRCS may be changed by mkc.conf.mk
_srcsall +=	${SRCS.${p}}
.endfor

.if defined(PROG)
PROGS         ?=	${PROG}
SRCS          ?=	${PROG}.c
SRCS.${PROG}  ?=	${SRCS}
_srcsall +=	${SRCS}
.elif ${.CURDIR:T} == ${COMPATLIB:U}
SRCS     ?=	${FEATURESDIR}/_mkcfake.c
_srcsall +=	${SRCS}
.elif defined(LIB)
SRCS     ?=	${LIB}.c
_srcsall +=	${SRCS}
.endif # defined(PROG)

.include "mkc_imp.compiler_type.mk"

src_type  ?=

LDREAL  ?=	${CC}

MKC_CACHEDIR ?=	${.OBJDIR} # directory for cache and intermediate files

###########

PROJECTNAME  ?=	${!empty(PROG):?${PROG}:${!empty(LIB):?${LIB}:${.CURDIR:T}}}

.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif defined(MKC_SYSCONFDIR) && exists(${MKC_SYSCONFDIR}/mk-c.conf)
.warning "Directory ${MKC_SYSCONFDIR}/mk-c.conf is deprecated since 2020-12-11, please rename it to ${MKC_SYSCONFDIR}/mkcmake.conf"
.include "${MKC_SYSCONFDIR}/mk-c.conf"
.elif defined(MKC_SYSCONFDIR) && exists(${MKC_SYSCONFDIR}/mkcmake.conf)
.include "${MKC_SYSCONFDIR}/mkcmake.conf"
.elif defined(MKC_SYSCONFDIR) && exists(${MKC_SYSCONFDIR}/mk.conf)
.include "${MKC_SYSCONFDIR}/mk.conf"
.endif

.if ${ID} != "@ID@"  #empty(MK_C_PROJECT)
_MKC_USER   !=	${ID:Uid} -un
_MKC_GROUP  !=	${ID:Uid} -gn
.else
_MKC_USER   =	fake
_MKC_GROUP  =	fake
.endif

.if ${_MKC_USER} != root && ${OPSYS}${_MKC_USER} != "InterixAdministrator"
ROOT_USER  ?=	${_MKC_USER}
ROOT_GROUP ?=	${_MKC_GROUP}
.endif

BINGRP     ?=	${ROOT_GROUP}
BINOWN     ?=	${ROOT_USER}

SHLIBMODE.HP-UX    =	${BINMODE}
SHLIBMODE.OSF1     =	${BINMODE}
SHLIBMODE.Interix  =	${BINMODE}
SHLIBMODE         ?=	${SHLIBMODE.${TARGET_OPSYS}:U${NONBINMODE}}

ROOT_GROUP.NetBSD    =	wheel
ROOT_GROUP.OpenBSD   =	wheel
ROOT_GROUP.FreeBSD   =	wheel
ROOT_GROUP.Darwin    =	wheel
ROOT_GROUP.DragonFly =	wheel
ROOT_GROUP.MirBSD    =	wheel
ROOT_GROUP.HP-UX     =	bin
ROOT_GROUP.OSF1      =	bin
ROOT_GROUP.Interix   =	+Administrators
ROOR_GROUP.Haiku     =	root

ROOT_USER.HP-UX   =	bin
ROOT_USER.OSF1    = 	bin
ROOT_USER.Interix =	Administrator
ROOT_USER.Haiku   =	user

ROOT_USER  ?=		${ROOT_USER.${OPSYS}:Uroot}
ROOT_GROUP ?=		${ROOT_GROUP.${OPSYS}:Uroot}

BINMODE.Interix.Administrator    =	775
NONBINMODE.Interix.Administrator =	664

BINMODE    ?=		${BINMODE.${TARGET_OPSYS}.${ROOT_USER}:U755}
NONBINMODE ?=		${BINMODE.${TARGET_OPSYS}.${ROOT_USER}:U644}
DIRMODE    ?=		${BINMODE}

MANGRP     ?=	${ROOT_GROUP}
MANOWN     ?=	${ROOT_USER}
MANMODE    ?=	${NONBINMODE}
MANINSTALL ?=	maninstall catinstall

INFOGRP    ?=	${ROOT_GROUP}
INFOOWN    ?=	${ROOT_USER}
INFOMODE   ?=	${NONBINMODE}

LIBGRP     ?=	${BINGRP}
LIBOWN     ?=	${BINOWN}
LIBMODE    ?=	${NONBINMODE}

DOCGRP     ?=	${ROOT_GROUP}
DOCOWN     ?=	${ROOT_USER}
DOCMODE    ?=	${NONBINMODE}

FILESOWN   ?=	${BINOWN}
FILESGRP   ?=	${BINGRP}
FILESMODE  ?=	${NONBINMODE}

SCRIPTSOWN  ?=	${BINOWN}
SCRIPTSGRP  ?=	${BINGRP}
SCRIPTSMODE ?=	${BINMODE}

MKINSTALL ?=	yes

MKCATPAGES ?=	no
MKHTML     ?=	no
MKDOC      ?=	yes
MKINFO     ?=	yes
MKMAN      ?=	yes
MKSHARE    ?=	yes

#
# MKOBJDIRS controls whether object dirs are created during "make all" or "make obj".
#
MKOBJDIRS    ?=	auto
MKRELOBJDIR  ?=	no

MKINSTALLDIRS   ?=	yes

CLEANDIRFILES  +=	${MKC_CACHEDIR}/_mkc_*

MKDLL     ?=	no
.if ${MKDLL:tl} == "only"
MKDLL      =	yes
MKSTATICLIB ?=	no
.else
MKSTATICLIB ?=	yes
.endif # MKDLL

.if !empty(STATICLIBS:M${.CURDIR:T})
MKPICLIB     ?=	yes
.else
MKPICLIB     ?=	no
.endif

SHLIB_MINOR ?=	0
.if ${MKDLL:tl} != "no"
SHLIB_MAJOR ?=	1
.endif # MKDLL

MKPROFILELIB    ?=	no

.if defined(SHLIB_MAJOR) && empty(STATICLIBS:M${.CURDIR:T})
MKSHLIB  ?=	yes
.else
MKSHLIB  ?=	no
.endif # SHLIB_MAJOR

.include "mkc_imp.platform.mk"

MESSAGE.ar ?=	@${_MESSAGE} "AR: ${.TARGET}"

COMPILE.s ?=	${_V} ${CC_PREFIX} ${CC} ${AFLAGS} -c
MESSAGE.s ?=	@${_MESSAGE} "AS: ${.IMPSRC}"

COMPILE.c ?=	${_V} ${CC_PREFIX} ${CC} ${_CPPFLAGS} ${CPPFLAGS_${_PN}} ${CPPFLAGS_${<:T}} ${CFLAGS.warns} ${_CFLAGS} ${CFLAGS_${_PN}} ${CFLAGS_${<:T}} -c
MESSAGE.c ?=	@${_MESSAGE} "CC: ${.IMPSRC}"

COMPILE.cc ?=	${_V} ${CXX_PREFIX} ${CXX} ${_CPPFLAGS} ${CPPFLAGS_${_PN}} ${CPPFLAGS_${<:T}} ${CXXFLAGS.warns} ${_CXXFLAGS} ${CXXFLAGS_${_PN}} ${CXXFLAGS_${<:T}} -c
MESSAGE.cc ?=	@${_MESSAGE} "CXX: ${.IMPSRC}"

_CPPFLAGS   =	${CPPFLAGS0} ${CPPFLAGS}
_CFLAGS     =	${CFLAGS0} ${_CFLAGS1} ${CFLAGS}
_CXXFLAGS   =	${CXXFLAGS0} ${_CXXFLAGS1} ${CXXFLAGS}

MESSAGE.ld ?=	@${_MESSAGE} "LD: ${.TARGET}"

LEX.l     ?=	${_V} ${LEX} ${LFLAGS}
MESSAGE.l ?=	@${_MESSAGE} "LEX: ${.IMPSRC}"

LD.SunOS  ?=	/usr/ccs/bin/ld
LD.OSF1   ?=	/usr/bin/ld
LD        ?=	${LD.${TARGET_OPSYS}:Uld}
LDFLAGS   ?=

.if ${OPSYS} == "Haiku"
LN        ?=	ln -s
LN_S      ?=	ln -s
.else
LN        ?=	ln
LN_S      ?=	${LN} -s
.endif

YACC.y    ?=	${_V} ${YACC} ${YFLAGS}
MESSAGE.y ?=	@${_MESSAGE} "YACC: ${.IMPSRC}"

MESSAGE.mkgen ?=	@${_MESSAGE} "MKGEN:"

TARGETS +=	all install clean cleandir depend test \
		installdirs uninstall configure filelist obj mkgen
TARGETS :=	${TARGETS:O:u}

ALLTARGETS +=	configure all install clean cleandir depend uninstall installdirs \
  mkgen bin_tar bin_targz bin_tarbz2 bin_zip bin_deb help help_use help_subprj

VERBOSE_ECHO ?=	echo

_PN =	${PROJECTNAME} # short synonym
# Lex
.if ${LPREFIX} != "yy"
LFLAGS +=	-P${LPREFIX}
.endif

# Yacc
YFLAGS +=	${YPREFIX:D-p${YPREFIX}} ${YHEADER:D-d}

EXPORT_VARNAMES +=	MKC_CACHEDIR TARGETS SHORTPRJNAME

EXPORT_DYNAMIC  ?=	no

INTERNALLIBS +=	${COMPATLIB}
STATICLIBS   +=	${INTERNALLIBS}

###########
.if exists(${SRCTOP}/Makefile.common)
.include "${SRCTOP}/Makefile.common"
.endif

.if ${.MAKE.LEVEL} != ${init_make_level} && exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

###########

PREFIX     ?=	/usr/local

BINDIR     ?=	${PREFIX}/bin
SBINDIR    ?=	${PREFIX}/sbin
FILESDIR   ?=	${PREFIX}/bin
LIBEXECDIR ?=	${PREFIX}/libexec
INCSDIR    ?=	${PREFIX}/include
DATADIR    ?=	${PREFIX}/share
SHAREDSTATEDIR    ?=	${PREFIX}/com
VARDIR     ?=	${PREFIX}/var
SYSCONFDIR ?=	${PREFIX}/etc
INFODIR    ?=	${PREFIX}/info
MANDIR     ?=	${PREFIX}/man
LIBDIR     ?=	${PREFIX}/lib
SCRIPTSDIR ?=	${BINDIR}

DOCDIR?     =	${DATADIR}/doc
HTMLDOCDIR ?=	${DOCDIR}/html
HTMLDIR    ?=	${MANDIR}

MKPIE     ?=	no
USE_SSP   ?=	no
USE_RELRO ?=	no
USE_FORT  ?=	no

######
.if ${USE_SSP:U:tl} == "yes"
_CFLAGS1     +=	${CFLAGS.ssp}
_CXXFLAGS1   +=	${CXXFLAGS.ssp}
.endif

.if ${USE_RELRO:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.relro}
.endif

.if ${USE_FORT:U:tl} == "yes"
CPPFLAGS +=	-D_FORTIFY_SOURCE=2
CFLAGS   +=	-O
.endif

CFLAGS     +=	${CFLAGS.std.${CCSTD}.${CC_TYPE}}
CXXFLAGS   +=	${CXXFLAGS.std.${CXXSTD}.${CXX_TYPE}}

SHRTOUT    ?=	no

.if ${SHRTOUT:tl} != "no"
_MESSAGE   ?=	echo
_MESSAGE_V ?=	:
_V         ?=	@
.else
_MESSAGE   ?=	:
_MESSAGE_V ?=	echo
_V         ?=
.endif

###########

###########

.endif # __initialized__
