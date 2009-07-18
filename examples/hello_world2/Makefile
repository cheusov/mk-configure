PROG=		hello_world
SRCS=		main.c msg.c

SCRIPTS=	hello_world2 hello_world3

.PHONY : all
test.out: all
	@./hello_world >  ${.TARGET}; \
	./hello_world2 >> ${.TARGET}; \
	./hello_world3 >> ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.prog.mk>
