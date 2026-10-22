MKC_CHECK_VARS    +=	errno:errno.h
MKC_CHECK_VARS    +=	bad_var:bar_header
MKC_CHECK_VARS    +=	mkc_test_var:string.h,include/mkc_test.h
MKC_CHECK_VARS    +=	mkc_test_var2:include/mkc_test.h

CPPFLAGS          +=	-I..

vars              :=	${MKC_CHECK_VARS:C/:.*,/:/:S,/,_,g:S/.h/_h/g:S/:/./g:S/^/HAVE_VAR./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
