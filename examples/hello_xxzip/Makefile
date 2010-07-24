PROG=		xxzip
# manual page will be generated from xxzip.pod document
MAN=		xxzip.1

MLINKS=		xxzip.1 xxunzip.1
MLINKS+=	xxzip.1 xxzcat.1

LINKS=		${BINDIR}/xxzip ${BINDIR}/xxunzip
LINKS+=		${BINDIR}/xxzip ${BINDIR}/xxzcat

#VERSION=	1.2.3
#POD2MAN_FLAGS+=	-r 'XXZIP-${VERSION}' -c 'XYZ'

WARNS=		4

CLEANFILES+=	xxzip.1

.include "test.mk"
.include <mkc.prog.mk>
