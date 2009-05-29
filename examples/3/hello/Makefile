PROG=		hello_world
SRCS=		main.c

MAN=		hello_world.1

INFILES=	hello_world.1
INSCRIPTS=	hello_world2

INTEXTS_SED+=	-e 's,@HELLO_VERSION@,${VERSION},'

SCRIPTS=	${INSCRIPTS}

.include "../libhello1/linkme.mk"
.include "../libhello2/linkme.mk"

DPLIBS+=	-lhello1 -lhello2

.include "../Makefile.version"

.include <mkc.intexts.mk>
.include <mkc.prog.mk>
