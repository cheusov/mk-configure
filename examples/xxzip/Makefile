PROG =		xxzip
MAN  =		xxzip.1

# manual page and tutorial will be generated from .pod documents, so
# we need pod2man and pod2html.
MKC_REQUIRE_PROGS =	${POD2MAN} ${POD2HTML}

MKPIE ?=	yes
USE_SSP ?=	yes
USE_RELRO ?=	yes

WARNS =		4

DOCDIR ?=	${DATADIR}/doc/${PROG}

MLINKS  =	xxzip.1 xxunzip.1
MLINKS +=	xxzip.1 xxzcat.1

LINKS  =	${BINDIR}/xxzip ${BINDIR}/xxunzip
LINKS +=	${BINDIR}/xxzip ${BINDIR}/xxzcat

FILES    =	tutorial.html
FILESDIR_tutorial.html =	${DOCDIR}

WARNS    =	4

CLEANFILES +=	xxzip.1 tutorial.html

.include "test.mk"
.include <mkc.prog.mk>
