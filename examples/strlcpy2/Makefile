MKC_SOURCE_FUNCLIBS  =	strlcpy getline
MKC_CHECK_FUNCS3    +=	strlcpy:string.h getline:stdio.h
MKC_SOURCE_DIR       =	${.CURDIR}/missing

PROG  =			hello
SRCS  =			hello.c

WARNS =			4

MKC_REQD =		0.26.0

.include "test.mk"
.include <mkc.prog.mk>
