# Copyright (c) 2009-2010 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef _MKC_IMP_SYS_MK
_MKC_IMP_SYS_MK := 1

.include <mkc_imp.platform.sys.mk>

.SUFFIXES: .a .o .op .os .s .S .c .cc .cpp .cxx .C .F .f .r .m .y .l .cl .p .h

.LIBS:		.a

.if ${MKPIE:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.pie}
CFLAGS +=	${CFLAGS.pie}
CXXFLAGS +=	${CXXFLAGS.pie}
.endif

.if ${USE_SSP:U:tl} == "yes"
CFLAGS +=	${CFLAGS.ssp}
CXXFLAGS +=	${CXXFLAGS.ssp}
.endif

.if ${USE_RELRO:U:tl} == "yes"
LDFLAGS.prog +=	${LDFLAGS.relro}
.endif

.if ${USE_FORT:U:tl} == "yes"
CPPFLAGS +=	-D_FORTIFY_SOURCE=2
.endif

SHRTOUT ?=	no

.if ${SHRTOUT:tl} != "no"
_MESSAGE   ?=	echo
_MESSAGE_V ?=	:
_V ?=		@
.else
_MESSAGE   ?=	:
_MESSAGE_V ?=	echo
_V ?=
.endif

AR ?=		ar
ARFLAGS ?=	rl
RANLIB ?=	ranlib
MESSAGE.ar ?=	@${_MESSAGE} "AR: ${.TARGET}"

AS        ?=	as
AFLAGS    ?=
COMPILE.s ?=	${_V} ${CC} ${AFLAGS} -c
LINK.s    ?=	${_V} ${CC} ${AFLAGS} ${LDFLAGS}
MESSAGE.s ?=	@${_MESSAGE} "AS: ${.IMPSRC}"

CC        ?=	cc
CFLAGS    ?=
COMPILE.c ?=	${_V} ${CC} ${CFLAGS} ${CPPFLAGS} ${CFLAGS.warnerr} -c
LINK.c    ?=	${_V} ${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} ${LDFLAGS.prog}
MESSAGE.c ?=	@${_MESSAGE} "CC: ${.IMPSRC}"

CXX        ?=	c++
CXXFLAGS   +=	${CFLAGS}
COMPILE.cc ?=	${_V} ${CXX} ${CXXFLAGS} ${CPPFLAGS} ${CFLAGS.warnerr} -c
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

INSTALL    ?=	install

LEX       ?=	lex
LFLAGS    ?=
LEX.l     ?=	${_V} ${LEX} ${LFLAGS}
MESSAGE.l ?=	@${_MESSAGE} "LEX: ${.IMPSRC}"

LD.SunOS  ?=	/usr/ccs/bin/ld
LD.OSF1   ?=	/usr/bin/ld
LD        ?=	${LD.${TARGET_OPSYS}:Uld}
LDFLAGS   ?=

LORDER    ?=	lorder

NM ?=		nm

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

#ADDR2LINE ?=	addr2line
#READELF   ?=	readelf
#STRINGS   ?=	strings

# C
.c.o:
	${MESSAGE.c}
	${COMPILE.c} ${.IMPSRC} -o ${.TARGET}
.c.op:
	${MESSAGE.c}
	${COMPILE.c} -pg ${.IMPSRC} -o ${.TARGET}
.c.os:
	${MESSAGE.c}
	${COMPILE.c} ${CFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

# C++
.cc.o .cpp.o .cxx.o .C.o:
	${MESSAGE.cc}
	${COMPILE.cc} ${.IMPSRC} -o ${.TARGET}
.cc.op .C.op .cpp.op:
	${MESSAGE.cc}
	${COMPILE.cc} -pg ${.IMPSRC} -o ${.TARGET}
.cc.os .C.os .cpp.os:
	${MESSAGE.cc}
	${COMPILE.cc} ${CXXFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

# Fortran/Ratfor
.f.o:
	${MESSAGE.f}
	${COMPILE.f} ${.IMPSRC} -o ${.TARGET}
.f.op:
	${MESSAGE.f}
	${COMPILE.f} -pg ${.IMPSRC} -o ${.TARGET}
.f.os:
	${MESSAGE.f}
	${COMPILE.f} ${FFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

#.F:
.F.o:
	${MESSAGE.F}
	${COMPILE.F} ${.IMPSRC} -o ${.TARGET}

#.r:
.r.o:
	${MESSAGE.r}
	${COMPILE.r} ${.IMPSRC} -o ${.TARGET}

# Pascal
.p.o:
	${MESSAGE.p}
	${COMPILE.p} ${.IMPSRC} -o ${.TARGET}

# Assembly
.S.o .s.o:
	${MESSAGE.s}
	${COMPILE.s} ${.IMPSRC} -o ${.TARGET}
.S.op .s.op:
	${MESSAGE.s}
	${COMPILE.s} -pg ${.IMPSRC} -o ${.TARGET}
.S.os .s.os:
	${MESSAGE.s}
	${COMPILE.s} ${CAFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

# Objective-C
.m.o:
	${MESSAGE.m}
	${COMPILE.m} ${.IMPSRC}
.m.op:
	${MESSAGE.m}
	${COMPILE.m} -pg ${.IMPSRC} -o ${.TARGET}
.m.os:
	${MESSAGE.m}
	${COMPILE.m} ${CMFLAGS.pic} ${.IMPSRC} -o ${.TARGET}

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

.endif
