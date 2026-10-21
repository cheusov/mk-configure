MKC_CHECK_HEADERS +=	sys/time.h string.h stdlib.h,unistd.h
MKC_CHECK_HEADERS +=	bad_dir/bad_header.h bad_header.h
MKC_CHECK_HEADERS +=	include/mkc_test.h

vars              :=	${MKC_CHECK_HEADERS:C/^.*,//:S,/,_,g:S/,/./g:S/./_/g:S/^/HAVE_HEADER./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
