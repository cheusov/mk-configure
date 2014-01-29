# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.SUFFIXES: .a .o .op .os .s .S .c .cc .cpp .cxx .C .F .f .r .m .y .l .cl .p .h

.LIBS:		.a

# C

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
.l.c:
	${MESSAGE.l}
	${LEX.l} -t ${.IMPSRC} > ${.TARGET}

# Yacc
.y.h: ${.TARGET:R}.c
.y.c:
	${MESSAGE.y}
	${YACC.y} ${.IMPSRC}
	${_V}mv y.tab.c ${.TARGET}
.ifdef YHEADER
	${_V}mv y.tab.h ${.TARGET:R}.h
.endif
