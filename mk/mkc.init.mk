# Copyright (c) 2009-2013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
# Copyright (c) 2009-2014 by Aleksey Cheusov
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

.ifdef DPLIBDIRS
.for _dir in ${DPLIBDIRS}
.ifndef DPLIBDIRS.${_dir}
.if ${SHORTPRJNAME:tl} == "yes"
DPLIBDIRS.${_dir} = 	${OBJDIR_${_dir:T}}
.else
DPLIBDIRS.${_dir} = 	${OBJDIR_${_dir:S,/,_,g}}
.endif
.if ${TARGET_OPSYS} == "HP-UX"
LDFLAGS0  +=	${CFLAGS.cctold}+b ${CFLAGS.cctold}${LIBDIR}
.endif
LDFLAGS0  +=	-L${DPLIBDIRS.${_dir}}
.endif
.endfor

#.undef DPLIBDIRS

.endif # DPLIBDIRS

######################################################################
.ifndef __initialized__
__initialized__ := 1

.MAIN:		all

###########
.sinclude <mkc_imp.vars.mk> # .sinclude for bootstrapping

#.if defined(MKC_SHELL)
#.SHELL: name=${MKC_SHELL}
#.elif ${OPSYS} == "SunOS"
#.SHELL: name=/usr/xpg4/bin/sh
#.endif

###########

.for p in ${PROGS}
SRCS.${p} ?=	${p}.c
SRCS.${p} +=	${SRCS} # SRCS may be changed by mkc_imp.configure.mk
_srcsall +=	${SRCS.${p}}
.endfor

.if defined(PROG)
PROGS         ?=	${PROG}
SRCS          ?=	${PROG}.c
SRCS.${PROG}  ?=	${SRCS}
_srcsall +=	${SRCS}
.elif defined(LIB)
SRCS     ?=	${LIB}.c
_srcsall +=	${SRCS}
.endif # defined(PROG)

.if !empty(_srcsall:U:M*.cxx) || !empty(_srcsall:U:M*.cpp) || !empty(_srcsall:U:M*.C) || !empty(_srcsall:U:M*.cc)
src_type   +=	cxx
LDCOMPILER  =	yes
LDREAL     ?=	${CXX}
.elif !empty(_srcsall:U:M*.pas) || !empty(_srcsall:U:M*.p)
src_type   +=	pas
LDCOMPILER  =	yes
LDREAL     ?=	${PC}
.endif

LDCOMPILER.Interix =	yes
LDCOMPILER.Darwin  =	yes
#LDCOMPILER.HP-UX=	yes
LDCOMPILER        ?=	${LDCOMPILER.${TARGET_OPSYS}:Uyes}

.if !empty(_srcsall:U:M*.c) || !empty(_srcsall:U:M*.l) || !empty(_srcsall:U:M*.y) || defined(MKC_SOURCE_FUNCLIBS)
src_type  +=	c
.endif

src_type  ?=	0

.if ${LDCOMPILER:tl} == "yes"
LDREAL  ?=	${CC}
.endif

.if defined(PROGS)
LDREAL  ?=	${CC}
.else
LDREAL  ?=	${LD}
.endif

MKC_CACHEDIR ?=	${.OBJDIR} # directory for cache and intermediate files

init_make_level ?= 0 # for mkc.configure.mk

.if ${.MAKE.LEVEL} == ${init_make_level}
SRCTOP       ?=	${.CURDIR}
OBJTOP       ?=	${.OBJDIR}
.export SRCTOP OBJTOP
.endif

###########
.if exists(${SRCTOP}/Makefile.common)
.include "${SRCTOP}/Makefile.common"
.endif

.if ${SRCTOP:U} != ${.CURDIR} && exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

###########

PROJECTNAME  ?=	${!empty(PROG):?${PROG}:${!empty(LIB):?${LIB}:${.CURDIR:T}}}

.if defined(MAKECONF) && exists(${MAKECONF})
.include "${MAKECONF}"
.elif defined(MKC_SYSCONFDIR) && exists(${MKC_SYSCONFDIR}/mk.conf)
.include "${MKC_SYSCONFDIR}/mk.conf"
.elif exists(/etc/mk.conf)
.include "/etc/mk.conf"
.endif

.if ${OPSYS:Ux} == "SunOS"
_MKC_USER   !=	/usr/xpg4/bin/id -un
_MKC_GROUP  !=	/usr/xpg4/bin/id -gn
.else
_MKC_USER   !=	id -un
_MKC_GROUP  !=	id -gn
.endif

.if ${_MKC_USER} != root && ${OPSYS}${_MKC_USER} != "InterixAdministrator"
ROOT_USER  ?=	${_MKC_USER}
ROOT_GROUP ?=	${_MKC_GROUP}
.endif

# Define MANZ to have the man pages compressed (gzip)
#MANZ=		1

PREFIX     ?=	/usr/local

BINDIR     ?=	${PREFIX}/bin
SBINDIR    ?=	${PREFIX}/sbin
FILESDIR   ?=	${PREFIX}/bin
LIBEXECDIR ?=	${PREFIX}/libexec
INCSDIR    ?=	${PREFIX}/include
DATADIR    ?=	${PREFIX}/share
SYSCONFDIR ?=	${PREFIX}/etc
INFODIR    ?=	${PREFIX}/info
MANDIR     ?=	${PREFIX}/man
LIBDIR     ?=	${PREFIX}/lib
SCRIPTSDIR ?=	${BINDIR}

DOCDIR?     =	${DATADIR}/doc
HTMLDOCDIR ?=	${DOCDIR}/html
HTMLDIR    ?=	${MANDIR}

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

COPY        ?=		-c
PRESERVE    ?=
STRIPFLAG   ?=	-s

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
MKOBJDIRS     ?=	auto
MKRELOBJDIR  ?=	no

MKPIE     ?=	no
USE_SSP   ?=	no
USE_RELRO ?=	no
USE_FORT  ?=	no

MKDLL     ?=	no
.if ${MKDLL:tl} == "only"
MKDLL      =	yes
MKSTATICLIB ?=	no
.else
MKSTATICLIB ?=	yes
.endif # MKDLL

SHLIB_MINOR ?=	0
.if ${MKDLL:tl} != "no"
SHLIB_MAJOR ?=	1
.endif # MKDLL

.if defined(SHLIB_MAJOR)
MKSHLIB  ?=	yes
.else
MKSHLIB  ?=	no
.endif # SHLIB_MAJOR

MKPICLIB ?=	no
MKPROFILELIB ?=	no

MKINSTALLDIRS   ?=	yes

EXPORT_VARNAMES +=	MKC_CACHEDIR TARGETS SHORTPRJNAME

EXPORT_DYNAMIC  ?=	no

DISTCLEANFILES  +=	${MKC_CACHEDIR}/_mkc_*

.include <mkc_imp.platform.sys.mk>

######
.if ${MKPIE:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.pie}
_CFLAGS.pie   +=	${CFLAGS.pie}
_CXXFLAGS.pie +=	${CXXFLAGS.pie}
.endif

.if ${USE_SSP:U:tl} == "yes"
_CFLAGS.ssp   =	${CFLAGS.ssp}
_CXXFLAGS.ssp =	${CXXFLAGS.ssp}
.endif

.if ${USE_RELRO:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.relro}
.endif

.if ${USE_FORT:U:tl} == "yes"
CPPFLAGS +=	-D_FORTIFY_SOURCE=2
CFLAGS   +=	-O
.endif

SHRTOUT        ?=	no

.if ${SHRTOUT:tl} != "no"
_MESSAGE   ?=	echo
_MESSAGE_V ?=	:
_V         ?=	@
.else
_MESSAGE   ?=	:
_MESSAGE_V ?=	echo
_V         ?=
.endif

AR         ?=	ar
ARFLAGS    ?=	rl
RANLIB     ?=	ranlib
MESSAGE.ar ?=	@${_MESSAGE} "AR: ${.TARGET}"

AS        ?=	as
AFLAGS    ?=
COMPILE.s ?=	${_V} ${CC_PREFIX} ${CC} ${AFLAGS} -c
MESSAGE.s ?=	@${_MESSAGE} "AS: ${.IMPSRC}"

CC        ?=	cc
CFLAGS    ?=
COMPILE.c ?=	${_V} ${CC_PREFIX} ${CC} ${CFLAGS} ${CPPFLAGS} ${_CFLAGS.ssp} ${_CFLAGS.pie} ${CFLAGS.warns} -c
MESSAGE.c ?=	@${_MESSAGE} "CC: ${.IMPSRC}"

CXX        ?=	c++
CXXFLAGS   +=	${CFLAGS}
COMPILE.cc ?=	${_V} ${CXX_PREFIX} ${CXX} ${CXXFLAGS} ${CPPFLAGS} ${_CXXFLAGS.ssp} ${_CXXFLAGS.pie} ${CXXFLAGS.warns} -c
MESSAGE.cc ?=	@${_MESSAGE} "CXX: ${.IMPSRC}"

OBJC       ?=	${CC}
OBJCFLAGS  ?=	${CFLAGS}
COMPILE.m  ?=	${_V} ${OBJC} ${OBJCFLAGS} ${CPPFLAGS} -c
MESSAGE.m  ?=	@${_MESSAGE} "OBJC: ${.IMPSRC}"

CPP        ?=	cpp
CPPFLAGS   ?=	

FC         ?=	f77
FFLAGS     ?=	-O
RFLAGS     ?=
COMPILE.f  ?=	${_V} ${FC} ${FFLAGS} -c
MESSAGE.f  ?=	@${_MESSAGE} "FC: ${.IMPSRC}"
COMPILE.F  ?=	${_V} ${FC} ${FFLAGS} ${CPPFLAGS} -c
MESSAGE.F  ?=	${MESSAGE.f}
COMPILE.r  ?=	${_V} ${FC} ${FFLAGS} ${RFLAGS} -c
MESSAGE.r  ?=	${MESSAGE.f}

MESSAGE.ld ?=	@${_MESSAGE} "LD: ${.TARGET}"

CLEANFILES_CMD ?=	${RM} -f
CLEANDIRS_CMD ?=	${RM} -rf

INSTALL    ?=	install
UNINSTALL  ?=	${RM} -f

LEX       ?=	lex
LFLAGS    ?=
LEX.l     ?=	${_V} ${LEX} ${LFLAGS}
MESSAGE.l ?=	@${_MESSAGE} "LEX: ${.IMPSRC}"

LD.SunOS  ?=	/usr/ccs/bin/ld
LD.OSF1   ?=	/usr/bin/ld
LD        ?=	${LD.${TARGET_OPSYS}:Uld}
LDFLAGS   ?=

LN        ?=	ln
LN_S      ?=	${LN} -s

LORDER    ?=	lorder

NM        ?=	nm

MKDIR     ?=	mkdir

PC        ?=	pc
PFLAGS    ?=
COMPILE.p ?=	${_V} ${PC} ${PFLAGS} ${CPPFLAGS} -c
MESSAGE.p ?=	@${_MESSAGE} "PC: ${.IMPSRC}"

SHELL     ?=	sh

SIZE      ?=	size

TSORT     ?= 	tsort -q

YACC      ?=	yacc
YFLAGS    ?=
YACC.y    ?=	${_V} ${YACC} ${YFLAGS}
MESSAGE.y ?=	@${_MESSAGE} "YACC: ${.IMPSRC}"

TAR       ?=	tar
GZIP      ?=	gzip
BZIP2     ?=	bzip2
ZIP       ?=	zip

OBJCOPY   ?=    objcopy

OBJDUMP   ?=    objdump

STRIP     ?=	strip

RM        ?=	rm

#ADDR2LINE ?=	addr2line
#READELF   ?=	readelf
#STRINGS   ?=	strings

_PN =	${PROJECTNAME} # short synonym
# Lex
LPREFIX ?=	yy
.if ${LPREFIX} != "yy"
LFLAGS +=	-P${LPREFIX}
.endif
LEXLIB ?=	-ll

# Yacc
YFLAGS +=	${YPREFIX:D-p${YPREFIX}} ${YHEADER:D-d}

###########

.if defined(MKC_REQD) && defined(MKC_VERSION)
_mkc_version_ok  !=	mkc_check_version ${MKC_REQD} ${MKC_VERSION}
.if !${_mkc_version_ok}
MKC_ERR_MSG +=	"ERROR: We need mk-configure v.${MKC_REQD} while ${MKC_VERSION} is detected"
MKCHECKS     =	no
.endif
.endif

###########

TARGETS +=	all install clean cleandir depend test \
		installdirs uninstall errorcheck filelist obj
TARGETS :=	${TARGETS:O:u}

VERBOSE_ECHO ?=	echo

.endif # __initialized__
