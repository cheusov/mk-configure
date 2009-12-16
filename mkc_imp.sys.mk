# Copyright (c) 2009 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.platform.sys.mk>

.SUFFIXES: .out .a .o .s .S .c .cc .cpp .cxx .C .F .f .r .y .l .cl .p .h
.SUFFIXES: .sh .m4

.LIBS:		.a

AR?=		ar
ARFLAGS?=	rl
RANLIB?=	ranlib

AS?=		as
AFLAGS?=
COMPILE.s?=	${CC} ${AFLAGS} -c
LINK.s?=	${CC} ${AFLAGS} ${LDFLAGS}
COMPILE.S?=	${CC} ${AFLAGS} ${CPPFLAGS} -c -traditional-cpp
LINK.S?=	${CC} ${AFLAGS} ${CPPFLAGS} ${LDFLAGS}

CC?=		cc
CFLAGS?=
COMPILE.c?=	${CC} ${CFLAGS} ${CPPFLAGS} -c
LINK.c?=	${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}

CXX?=		c++
CXXFLAGS?=	${CFLAGS}
COMPILE.cc?=	${CXX} ${CXXFLAGS} ${CPPFLAGS} -c
LINK.cc?=	${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS}

OBJC?=		${CC}
OBJCFLAGS?=	${CFLAGS}
COMPILE.m?=	${OBJC} ${OBJCFLAGS} ${CPPFLAGS} -c
LINK.m?=	${OBJC} ${OBJCFLAGS} ${CPPFLAGS} ${LDFLAGS}

CPP?=		cpp
CPPFLAGS?=	

FC?=		f77
FFLAGS?=	-O
RFLAGS?=
COMPILE.f?=	${FC} ${FFLAGS} -c
LINK.f?=	${FC} ${FFLAGS} ${LDFLAGS}
COMPILE.F?=	${FC} ${FFLAGS} ${CPPFLAGS} -c
LINK.F?=	${FC} ${FFLAGS} ${CPPFLAGS} ${LDFLAGS}
COMPILE.r?=	${FC} ${FFLAGS} ${RFLAGS} -c
LINK.r?=	${FC} ${FFLAGS} ${RFLAGS} ${LDFLAGS}

INSTALL?=	install

LEX?=		lex
LFLAGS?=
LEX.l?=		${LEX} ${LFLAGS}

LD?=		ld
LDFLAGS?=

LORDER?=	lorder

NM?=		nm

PC?=		pc
PFLAGS?=
COMPILE.p?=	${PC} ${PFLAGS} ${CPPFLAGS} -c
LINK.p?=	${PC} ${PFLAGS} ${CPPFLAGS} ${LDFLAGS}

SHELL?=		sh

SIZE?=		size

TSORT?= 	tsort -q

YACC?=		yacc
YFLAGS?=
YACC.y?=	${YACC} ${YFLAGS}

# C
.c.o:
	${COMPILE.c} ${.IMPSRC}

# C++
.cc.o .cpp.o .cxx.o .C.o:
	${COMPILE.cc} ${.IMPSRC}

# Fortran/Ratfor
.f.o:
	${COMPILE.f} ${.IMPSRC}

#.F:
.F.o:
	${COMPILE.F} ${.IMPSRC}

#.r:
.r.o:
	${COMPILE.r} ${.IMPSRC}

# Pascal
.p.o:
	${COMPILE.p} ${.IMPSRC}

# Assembly
.s.o:
	${COMPILE.s} ${.IMPSRC}
.S.o:
	${COMPILE.S} ${.IMPSRC}

# Lex
.l.c:
	${LEX.l} ${.IMPSRC}
	mv lex.yy.c ${.TARGET}

# Yacc
.y.c:
	${YACC.y} ${.IMPSRC}
	mv y.tab.c ${.TARGET}

# Shell
.sh:
	rm -f ${.TARGET}
	cp ${.IMPSRC} ${.TARGET}
