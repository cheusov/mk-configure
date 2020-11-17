PROG =			hello_customtests2

WARNS =			4

MKC_CUSTOM_DIR =	${.CURDIR}/../customtests/custom_tests

MKC_CHECK_CUSTOM =	alloca_in_stdlib_h alloca_in_alloca_h \
			true_is_available

# full path is for regression test
MKC_CUSTOM_FN.true_is_available =	${MKC_CUSTOM_DIR}/true_is_available

MKC_REQD =		0.11.0

.include "test.mk"
.include <mkc.prog.mk>
