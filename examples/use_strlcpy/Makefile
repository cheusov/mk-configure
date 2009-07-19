MKC_SOURCE_FUNCLIBS=	strlcpy
MKC_CHECK_FUNCS3+=	strlcpy:string.h

PROG=			hello4
SRCS=			hello.c
MKMAN=			no

.PHONY : all
${.CURDIR:T}.test.out: all
	@${.OBJDIR}/hello4 > ${.TARGET} < ${.CURDIR}/input.in

.include <mkc.minitest.mk>
.include <mkc.configure.mk>
.include <mkc.prog.mk>
