PROG=		xxzip
# manual page will be generated from xxzip.pod document
MAN=		xxzip.1

WARNS=		4

DOCDIR?=	${DATADIR}/doc/${PROG}

MLINKS=		xxzip.1 xxunzip.1
MLINKS+=	xxzip.1 xxzcat.1

LINKS=		${BINDIR}/xxzip ${BINDIR}/xxunzip
LINKS+=		${BINDIR}/xxzip ${BINDIR}/xxzcat

FILES=		tutorial.html
FILESDIR=	${DOCDIR}

WARNS=		4

CLEANFILES+=	xxzip.1 tutorial.html

.include "test.mk"
.include <mkc.prog.mk>
