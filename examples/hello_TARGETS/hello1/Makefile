PROG  = hello1
MAN   =	hello1.1

WARNS = 4

CLEANFILES = hello1.1

_manpages: ${MAN}

# the following is just a regression test for exporting TARGETS
.if empty(TARGETS:Mcoding*)
MKC_ERR_MSG = "qqq"
.endif

.include <mkc.mk>
