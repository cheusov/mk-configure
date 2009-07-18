MKC_SOURCE_FUNCLIBS=	strlcpy
MKC_CHECK_FUNCS3+=	strlcpy:string.h

PROG=			hello4
SRCS=			hello.c
MKMAN=			no

.PHONY : all
test.out: all
	@./hello4 > ${.TARGET} < input.in

.include <mkc.minitest.mk>
.include <mkc.configure.mk>
.include <mkc.prog.mk>
