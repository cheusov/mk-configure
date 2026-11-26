PROG   =	lexer
SRCS   =	lexer.l

DPSRCS =	lexer.c

MKC_FEATURES  =	libl

CFLAGS.check +=	-Wno-unused-function
COPTS.check  +=	-mcpu=native -mtune=native

.include "test.mk"
.include <mkc.prog.mk>
