# Copyright (c) 2009-2013 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
# Copyright (c) 2009-2010 by Aleksey Cheusov
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
LDFLAGS  +=	${CFLAGS.cctold}+b ${CFLAGS.cctold}${LIBDIR}
.endif
LDFLAGS  +=	-L${DPLIBDIRS.${_dir}}
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
LDCOMPILER        ?=	${LDCOMPILER.${TARGET_OPSYS}:Uno}

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

###########
.if exists(${.CURDIR}/Makefile.rec)
REC_MAKEFILES +=	${.CURDIR}/Makefile.rec
.endif
.for dir in ${REC_MAKEFILES}
.include "${dir}"
.endfor

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

ROOT_GROUP.NetBSD    =		wheel
ROOT_GROUP.OpenBSD   =		wheel
ROOT_GROUP.FreeBSD   =		wheel
ROOT_GROUP.Darwin    =		wheel
ROOT_GROUP.DragonFly =		wheel
ROOT_GROUP.MirBSD    =		wheel
ROOT_GROUP.HP-UX     =		bin
ROOT_GROUP.OSF1      =		bin
ROOT_GROUP.Interix   =		+Administrators
ROOR_GROUP.Haiku     =		root

ROOT_USER.HP-UX   =		bin
ROOT_USER.OSF1    = 		bin
ROOT_USER.Interix =		Administrator
ROOT_USER.Haiku   =		user

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
MKOBJDIRS ?=	auto

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

EXPORT_VARNAMES +=	MKC_CACHEDIR REC_MAKEFILES TARGETS SHORTPRJNAME

EXPORT_DYNAMIC  ?=	no

DISTCLEANFILES  +=	${MKC_CACHEDIR}/_mkc_*

.include <mkc_imp.platform.sys.mk>

######
.SUFFIXES: .a .o .op .os .s .S .c .cc .cpp .cxx .C .F .f .r .m .y .l .cl .p .h

.LIBS:		.a

.if ${MKPIE:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.pie}
CFLAGS       +=	${CFLAGS.pie}
CXXFLAGS     +=	${CXXFLAGS.pie}
.endif

.if ${USE_SSP:U:tl} == "yes"
CFLAGS   +=	${CFLAGS.ssp}
CXXFLAGS +=	${CXXFLAGS.ssp}
.endif

.if ${USE_RELRO:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.relro}
.endif

.if ${USE_FORT:U:tl} == "yes"
CPPFLAGS +=	-D_FORTIFY_SOURCE=2
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
LINK.s    ?=	${_V} ${CC} ${AFLAGS} ${LDFLAGS}
MESSAGE.s ?=	@${_MESSAGE} "AS: ${.IMPSRC}"

CC        ?=	cc
CFLAGS    ?=
COMPILE.c ?=	${_V} ${CC_PREFIX} ${CC} ${CFLAGS} ${CPPFLAGS} ${CFLAGS.warnerr} -c
LINK.c    ?=	${_V} ${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} ${LDFLAGS.prog}
MESSAGE.c ?=	@${_MESSAGE} "CC: ${.IMPSRC}"

CXX        ?=	c++
CXXFLAGS   +=	${CFLAGS}
COMPILE.cc ?=	${_V} ${CXX_PREFIX} ${CXX} ${CXXFLAGS} ${CPPFLAGS} ${CFLAGS.warnerr} -c
LINK.cc    ?=	${_V} ${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} ${LDFLAGS.prog}
MESSAGE.cc ?=	@${_MESSAGE} "CXX: ${.IMPSRC}"

OBJC       ?=	${CC}
OBJCFLAGS  ?=	${CFLAGS}
COMPILE.m  ?=	${_V} ${OBJC} ${OBJCFLAGS} ${CPPFLAGS} -c
LINK.m     ?=	${_V} ${OBJC} ${OBJCFLAGS} ${CPPFLAGS} ${LDFLAGS}
MESSAGE.m  ?=	@${_MESSAGE} "OBJC: ${.IMPSRC}"

CPP        ?=	cpp
CPPFLAGS   ?=	

FC         ?=	f77
FFLAGS     ?=	-O
RFLAGS     ?=
COMPILE.f  ?=	${_V} ${FC} ${FFLAGS} -c
LINK.f     ?=	${_V} ${FC} ${FFLAGS} ${LDFLAGS}
MESSAGE.f  ?=	@${_MESSAGE} "FC: ${.IMPSRC}"
COMPILE.F  ?=	${_V} ${FC} ${FFLAGS} ${CPPFLAGS} -c
LINK.F     ?=	${_V} ${FC} ${FFLAGS} ${CPPFLAGS} ${LDFLAGS}
MESSAGE.F  ?=	${MESSAGE.f}
COMPILE.r  ?=	${_V} ${FC} ${FFLAGS} ${RFLAGS} -c
LINK.r     ?=	${_V} ${FC} ${FFLAGS} ${RFLAGS} ${LDFLAGS}
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
LINK.p    ?=	${_V} ${PC} ${PFLAGS} ${CPPFLAGS} ${LDFLAGS}
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

# C
_PN =	${PROJECTNAME} # short synonym

.c.o:
	${MESSAGE.c}
	${COMPILE.c} ${CPPFLAGS_${_PN}} ${CFLAGS_${_PN}} \
		${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.c.op:
	${MESSAGE.c}
	${COMPILE.c} -pg ${CPPFLAGS_${_PN}} ${CFLAGS_${_PN}} \
		${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.c.os:
	${MESSAGE.c}
	${COMPILE.c} ${CFLAGS.pic} ${CPPFLAGS_${_PN}} \
		${CFLAGS_${_PN}} ${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}

# C++
.cc.o .cpp.o .cxx.o .C.o:
	${MESSAGE.cc}
	${COMPILE.cc} ${CPPFLAGS_${_PN}} ${CXXFLAGS_${_PN}} \
		${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.cc.op .C.op .cpp.op:
	${MESSAGE.cc}
	${COMPILE.cc} -pg ${CPPFLAGS_${_PN}} ${CXXFLAGS_${_PN}} \
		${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.cc.os .C.os .cpp.os:
	${MESSAGE.cc}
	${COMPILE.cc} ${CXXFLAGS.pic} ${CPPFLAGS_${_PN}} \
		${CXXFLAGS_${_PN}} ${COPTS_${_PN}} -o ${.TARGET} ${.IMPSRC}

# Fortran/Ratfor
.f.o:
	${MESSAGE.f}
	${COMPILE.f} ${FFLAGS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.f.op:
	${MESSAGE.f}
	${COMPILE.f} -pg ${FFLAGS_${_PN}} -o ${.TARGET} ${.IMPSRC}
.f.os:
	${MESSAGE.f}
	${COMPILE.f} ${FFLAGS.pic} ${FFLAGS_${_PN}} -o ${.TARGET} ${.IMPSRC}

#.F:
.F.o:
	${MESSAGE.F}
	${COMPILE.F} -o ${.TARGET} ${.IMPSRC}

#.r:
.r.o:
	${MESSAGE.r}
	${COMPILE.r} -o ${.TARGET} ${.IMPSRC}

# Pascal
.p.o:
	${MESSAGE.p}
	${COMPILE.p} -o ${.TARGET} ${.IMPSRC}

# Assembly
.S.o .s.o:
	${MESSAGE.s}
	${COMPILE.s} -o ${.TARGET} ${.IMPSRC}
.S.op .s.op:
	${MESSAGE.s}
	${COMPILE.s} -o ${.TARGET} -pg ${.IMPSRC}
.S.os .s.os:
	${MESSAGE.s}
	${COMPILE.s} ${CAFLAGS.pic} -o ${.TARGET} ${.IMPSRC}

# Objective-C
.m.o:
	${MESSAGE.m}
	${COMPILE.m} ${.IMPSRC}
.m.op:
	${MESSAGE.m}
	${COMPILE.m} -pg -o ${.TARGET} ${.IMPSRC}
.m.os:
	${MESSAGE.m}
	${COMPILE.m} ${CMFLAGS.pic} -o ${.TARGET} ${.IMPSRC}

# Lex
LPREFIX ?=	yy
.if ${LPREFIX} != "yy"
LFLAGS +=	-P${LPREFIX}
.endif
LEXLIB ?=	-ll

.l.c:
	${MESSAGE.l}
	${LEX.l} -t ${.IMPSRC} > ${.TARGET}

# Yacc
YFLAGS +=	${YPREFIX:D-p${YPREFIX}} ${YHEADER:D-d}

.y.h: ${.TARGET:R}.c
.y.c:
	${MESSAGE.y}
	${YACC.y} ${.IMPSRC}
	${_V}mv y.tab.c ${.TARGET}
.ifdef YHEADER
	${_V}mv y.tab.h ${.TARGET:R}.h
.endif

###########
.include <mkc_imp.obj.mk>

###########
.if !empty(_srcsall:U:M*.y)
MKC_REQUIRE_PROGS  +=			${YACC:[1]}
MKC_PROG.id.${YACC:[1]:S/+/x/g}  =	yacc
.endif

.if !empty(_srcsall:U:M*.l)
MKC_REQUIRE_PROGS  +=			${LEX:[1]}
MKC_PROG.id.${LEX:[1]:S/+/x/g}   =	lex
.endif

.if !empty(_srcsall:U:M*.c) || !empty(_srcsall:U:M*.l) || !empty(_srcsall:U:M*.y)
MKC_REQUIRE_PROGS  +=			${CC:[1]}
MKC_PROG.id.${CC:[1]:S|+|x|g}    =	cc
.endif

.if !empty(_srcsall:U:M*.cc) || !empty(_srcsall:U:M*.C) || !empty(_srcsall:U:M*.cxx) || !empty(_srcsall:U:M*.cpp)
MKC_REQUIRE_PROGS  +=			${CXX:[1]}
MKC_PROG.id.${CXX:[1]:S/+/x/g}   =	cxx
.endif

.if !empty(_srcsall:U:M*.f)
MKC_REQUIRE_PROGS  +=			${FC:[1]}
MKC_PROG.id.${FC:[1]:S/+/x/g}    =	fc
.endif

.if !empty(_srcsall:U:M*.p)
MKC_REQUIRE_PROGS  +=			${PC:[1]}
MKC_PROG.id.${PC:[1]:S/+/x/g}    =	pc
.endif

###########
.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

.PHONY : print-values2
print-values2 :
.for v in ${VARS}
	@printf "%s\n" ${${v}:Q}
.endfor

###########
.PHONY: realall realerrorcheck

__errorcheck: .USE
	@if test -n '${MKC_ERR_MSG}'; then \
	    for msg in '' ${MKC_ERR_MSG}; do \
		fn=`printf '%s\n' "$$msg" | sed -n 's/^%%%: //p'`; \
		if test -n "$$fn"; then \
		    awk '{print "ERROR: " $$0}' "$$fn"; ex=1; \
		elif test -n "$$msg"; then printf '%s\n' "$$msg"; ex=1; \
		fi; \
	    done; \
	    exit $$ex; \
	fi

realall : realerrorcheck
realerrorcheck: __errorcheck

###########

.if defined(MKC_REQD) && defined(MKC_VERSION)
_mkc_version_ok  !=	mkc_check_version ${MKC_REQD} ${MKC_VERSION}
.if !${_mkc_version_ok}
MKC_ERR_MSG +=	"ERROR: We need mk-configure v.${MKC_REQD} while ${MKC_VERSION} is detected"
MKCHECKS     =	no
.endif
.endif

###########

LDLIBS =	${LDFLAGS} ${LDADD}

###########
# skip uninstalling files and creating destination dirs for mkc.subprj.mk
.if !defined(SUBPRJ)

uninstall:
	-${UNINSTALL} ${UNINSTALLFILES}

installdirs:
	for d in _ ${INSTALLDIRS:O:u:S|/.$||}; do \
		test "$$d" = _ || ${INSTALL} -d -m ${DIRMODE} "$$d"; \
	done

filelist:
	@for d in ${UNINSTALLFILES:O:u}; do \
		echo $$d; \
	done

test:

.endif # SUBPRJ

TARGETS +=	all all install clean cleandir depend test \
		installdirs uninstall errorcheck filelist obj
TARGETS := ${TARGETS:O:u}

# Make sure all of the standard targets are defined, even if they do nothing.
.PHONY: ${TARGETS} realinstall realinstall2 realall
${TARGETS} realinstall realinstall2 realall:

distclean:	cleandir

all:		realall

.if ${MKINSTALLDIRS:tl} == "yes"
install: installdirs .WAIT realinstall .WAIT realinstall2
.else
install: realinstall .WAIT realinstall2
.endif


###########

VERBOSE_ECHO ?=	echo
### for mkc.subdir.mk and mkc.subprj.mk
__recurse: .USE
	@targ=${.TARGET:S/^nodeps-//:C/-.*$//};				\
	dir=${.TARGET:S/^nodeps-//:C/^[^-]*-//};			\
	if ! test -f ${.CURDIR}/$$dir/Makefile; then exit 0; fi;	\
	test "$${targ}_${MKINSTALL:tl}" = 'install_no' && exit 0;       \
	test "$${targ}_${MKINSTALL:tl}" = 'installdirs_no' && exit 0;	\
	${export_cmd}							\
	set -e;								\
	${VERBOSE_ECHO} ================================================== 1>&2;\
	case "$$dir" in /*)						\
		${VERBOSE_ECHO} "$$targ ===> $$dir" 1>&2;		\
		cd "$$dir";						\
		env "_THISDIR_=$$dir/" ${MAKE} ${MAKEFLAGS} $$targ;		\
		;;							\
	*)								\
		${VERBOSE_ECHO} "$$targ ===> ${_THISDIR_}$$dir" 1>&2;	\
		cd "${.CURDIR}/$$dir";					\
		env "_THISDIR_=${_THISDIR_}$$dir/" ${MAKE} ${MAKEFLAGS} $$targ; \
		;;							\
	esac

###########

.endif # __initialized__
