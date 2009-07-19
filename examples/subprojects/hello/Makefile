PROG=		hello_subproject
SRCS=		main.c

MAN=		hello_subproject.1

INFILES=	hello_subproject.1
INSCRIPTS=	hello_subproject2

INTEXTS_SED+=	-e 's,@HELLO_VERSION@,${VERSION},'

SCRIPTS=	${INSCRIPTS}

.include "../libhello1/linkme.mk"
.include "../libhello2/linkme.mk"

DPLIBS+=	-lhello1 -lhello2

.include "../Makefile.version"

.include "test.mk"
.include <mkc.intexts.mk>
.include <mkc.prog.mk>
