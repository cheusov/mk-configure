MKC_COMMON_DEFINES  =		-DMKC_COMMON_DEFINES_WORKS_FINE
MKC_COMMON_DEFINES +=		-D__JUSTATEST

MKC_CHECK_DEFINES  +=	__BAD_DEFINE__
MKC_CHECK_DEFINES  +=	MKC_TEST_DEFINE:include/mkc_test.h
MKC_CHECK_DEFINES  +=	EINVAL:stdio.h,errno.h

CPPFLAGS           +=	-I..
vars               :=	${MKC_CHECK_DEFINES:C/:.*,/:/:S,/,_,g:S/.h/_h/g:S/:/./g:S/^/HAVE_DEFINE./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
