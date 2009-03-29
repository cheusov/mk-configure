PROG=		hello_world
SRCS=		main.c

LDADD+=		-lhello1 -lhello2

MAN=		hello_world.1

INFILES=	hello_world.1
INSCRIPTS=	hello_world2

INTEXTS_SED+=	-e 's,@HELLO_VERSION@,${VERSION},'

SCRIPTS=	${INSCRIPTS}

.include "../libhello1/linkme.mk"
.include "../libhello2/linkme.mk"

.include "../Makefile.version"

.include <mkc.intexts.mk>
.include <mkc.prog.mk>
