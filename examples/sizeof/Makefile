MKC_CHECK_SIZEOF+=	int long long-long size_t:string.h void*

PROG=			sizeof_test

MKMAN=			no

.PHONY : all
${.CURDIR:T}.test.out: all
	@${.OBJDIR}/sizeof_test | tr '1248' 'nnnn' >  ${.TARGET}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>
.include <mkc.prog.mk>
