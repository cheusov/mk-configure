PROG=			hello_customtests

MKC_CHECK_CUSTOM=	alloca_in_stdlib_h
MKC_CHECK_CUSTOM+=	alloca_in_alloca_h

MKC_CUSTOM_FN.alloca_in_stdlib_h = custom_tests/alloca_in_stdlib_h.c
MKC_CUSTOM_FN.alloca_in_alloca_h = custom_tests/alloca_in_alloca_h.c

MKC_REQD=		0.11.0

.include "test.mk"
.include <mkc.configure.mk>
.include <mkc.prog.mk>
