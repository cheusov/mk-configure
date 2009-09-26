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
