PROG=	hello_world

MKMAN=	no

.PHONY : all
${.CURDIR:T}.test.out: all
	@${.OBJDIR}/hello_world > ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
