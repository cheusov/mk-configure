# Copyright (c) 2014-2026 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.SUFFIXES: .a .o .op .os .s .S .c .c++ .cc .cpp .cxx .C .y .l .cl .p .h

.LIBS:		.a

# C

.c.o:
	${MESSAGE.c}
	${COMPILE.c} -o ${.TARGET} ${COPTS} ${COPTS_${_PN}} ${.IMPSRC}
.c.op:
	${MESSAGE.c}
	${COMPILE.c} -o ${.TARGET} ${CFLAGS.pg} ${COPTS} ${COPTS_${_PN}} ${.IMPSRC}
.c.os:
	${MESSAGE.c}
	${COMPILE.c} -o ${.TARGET} ${CFLAGS.pic} ${COPTS} ${COPTS_${_PN}} ${.IMPSRC}

# C++
.c++.o .cc.o .cpp.o .cxx.o .C.o:
	${MESSAGE.cc}
	${COMPILE.cc} -o ${.TARGET} ${CXXOPTS} ${CXXOPTS_${_PN}} ${.IMPSRC}
.c++.op .cc.op .cpp.op .cxx.op .C.op:
	${MESSAGE.cc}
	${COMPILE.cc} -o ${.TARGET} ${CXXFLAGS.pg} ${CXXOPTS} ${CXXOPTS_${_PN}} ${.IMPSRC}
.c++.os .cc.os .cpp.os .cxx.os .C.os:
	${MESSAGE.cc}
	${COMPILE.cc} -o ${.TARGET} ${CXXFLAGS.pic} ${CXXOPTS} ${CXXOPTS_${_PN}} ${.IMPSRC}

# Assembly
.S.o .s.o:
	${MESSAGE.s}
	${COMPILE.s} -o ${.TARGET} ${.IMPSRC}
.S.op .s.op:
	${MESSAGE.s}
	${COMPILE.s} -o ${.TARGET} -pg ${.IMPSRC}
.S.os .s.os:
	${MESSAGE.s}
	${COMPILE.s} -o ${.TARGET} ${CAFLAGS.pic} ${.IMPSRC}

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
