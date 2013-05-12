LIB  = qux
SRCS = qux.c
INCS = qux.h

MKC_CHECK_SIZEOF = int

.include <mkc.configure.mk>

INFILES       = ${INCS}
INTEXTS_REPLS = int_size ${SIZEOF.int:U4}

qux.o: qux.h

WARNS = 4

.include <mkc.lib.mk>
