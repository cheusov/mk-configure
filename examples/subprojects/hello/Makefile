PROG=		hello_subprojects
SRCS=		hello_subprojects.c

MAN=		hello_subprojects.1

INFILES=	hello_subprojects.1
INSCRIPTS=	hello_subprojects2

INTEXTS_SED+=	-e 's,@HELLO_VERSION@,${VERSION},'

MKC_CHECK_HEADERS+=	stdio.h

SCRIPTS=	${INSCRIPTS}

.include <mkc.configure.mk>

.include "../libhello1/linkme.mk"
.include "../libhello2/linkme.mk"

DPLIBS+=	-lhello1 -lhello2

.include "../version.mk"

.include "test.mk"
.include <mkc.intexts.mk>
.include <mkc.prog.mk>
