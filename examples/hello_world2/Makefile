PROG=		hello_world1
SRCS=		main.c msg.c

SCRIPTS=	hello_world2 hello_world3

MAN=		hello_world.1

.PHONY : all
${.CURDIR:T}.test.out: all
	@${.OBJDIR}/hello_world1 > ${.TARGET}; \
	${.CURDIR}/hello_world2 >> ${.TARGET}; \
	${.CURDIR}/hello_world3 >> ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
