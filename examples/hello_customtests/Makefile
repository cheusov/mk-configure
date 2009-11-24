PROG=			hello_customtests

MKC_CHECK_CUSTOM=	alloca_in_stdlib_h # C lang check
MKC_CHECK_CUSTOM+=	alloca_in_alloca_h # C lang check
MKC_CHECK_CUSTOM+=	cxx_with_templates # C++ lang check
MKC_CHECK_CUSTOM+=	true_is_available  # script-based check
MKC_CHECK_CUSTOM+=	shtest             # script-based check

MKC_CUSTOM_FN.alloca_in_stdlib_h = custom_tests/alloca_in_stdlib_h.c
MKC_CUSTOM_FN.alloca_in_alloca_h = custom_tests/alloca_in_alloca_h.c
MKC_CUSTOM_FN.cxx_with_templates = custom_tests/cxx_with_templates.cc
MKC_CUSTOM_FN.true_is_available  = custom_tests/true_is_available
MKC_CUSTOM_FN.shtest             = custom_tests/shtest

MKC_CUSTOM_endianess=	1

MKC_REQD=		0.12.0

.include <mkc.configure.mk>

CUSTOM.endianess?=
.if ${CUSTOM.endianess} != little && ${CUSTOM.endianess} != big
MKC_ERR_MSG=	"Do you run PDP-11?"
.endif

.include "test.mk"
.include <mkc.prog.mk>
