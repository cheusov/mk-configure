PROG  =			hello
SRCS  =			hello.c

WARNS =			4

.if !make(cleandir) # workaround for mk-configure development
MKC_FEATURES  =	CIRCLEQ LIST SIMPLEQ SLIST STAILQ TAILQ
.endif

MKC_REQD =		0.26.0

test: all
.include "test.mk"
.include <mkc.prog.mk>
