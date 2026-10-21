MKC_CHECK_HEADER_FILES +=	sys/time.h string.h stdlib.h,unistd.h
MKC_CHECK_HEADER_FILES +=	bad_dir/bad_header.h bad_header.h
MKC_CHECK_HEADER_FILES +=	include/mkc_test.h

vars :=	${MKC_CHECK_HEADER_FILES:C/^.*,//:S,/,_,g:S/,/./g:S/./_/g:S/^/HAVE_HEADER_FILE./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
