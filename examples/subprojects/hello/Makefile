PROG =		hello_subprojects
SRCS =		hello_subprojects.c

MAN  =		hello_subprojects.1

INFILES   =	hello_subprojects.1
INSCRIPTS =	hello_subprojects2

INTEXTS_REPLS +=	HELLO_VERSION ${VERSION}
INTEXTS_REPLS +=	MYEMAIL       vle@gmx.net

MKC_CHECK_HEADERS +=	stdio.h

SCRIPTS =	${INSCRIPTS}

.include <mkc.configure.mk>

.include "../libhello1/linkme.mk"
.include "../libhello2/linkme.mk"

.include "../version.mk"

.include "test.mk"
.include <mkc.prog.mk>
