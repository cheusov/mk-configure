# Setting specific to Darwin

COMPILE.s?=	${AS} ${AFLAGS}
COMPILE.S?=	${CC} ${AFLAGS} ${CPPFLAGS} -c

.if exists(/usr/bin/gcc)
CC?=		/usr/bin/gcc
.else
CC?=		cc
.endif

.if exists(/usr/bin/g++)
CXX?=		/usr/bin/g++
.else
CXX?=		c++
.endif

YFLAGS?=	-d

LDFLAGS_SHARED?=	-dylib
SHLIB_SHFLAGS?=

LINTFLAGS?=	-chapbx

LDFLAGS_WHOLEARCH?=
LDFLAGS_NOWHOLEARCH?=

SHLIB_EXT?=	.dylib
.if defined(SHLIB_MAJOR) && !empty(SHLIB_MAJOR)
SHLIB_EXT1?=	.${SHLIB_MAJOR}.dylib
.if defined(SHLIB_MINOR) && !empty(SHLIB_MINOR)
SHLIB_EXT2?=	.${SHLIB_MAJOR}.${SHLIB_MINOR}.dylib
.if defined(SHLIB_TEENY) && !empty(SHLIB_TEENY)
SHLIB_EXT3?=	.${SHLIB_FULLVERSION}.dylib
.endif
.endif
.endif

SHLIB_EXTFULL?=	.${SHLIB_FULLVERSION}.dylib

#### Test the default rules under Darwin
#.cc.a:
#	${COMPILE.cc} ${.IMPSRC}
#	${AR} ${ARFLAGS} $@ $*.o
#	rm -f $*.o
#.C:
#	${LINK.cc} -o ${.TARGET} ${.IMPSRC} ${LDLIBS}
#.C.o:
#	${COMPILE.cc} ${.IMPSRC}
#.s.o:
#	${COMPILE.s} ${.IMPSRC}
#	${COMPILE.s} -o ${.TARGET} ${.IMPSRC} 
