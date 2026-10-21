MKC_CHECK_TYPES+=	size_t:string.h
MKC_CHECK_TYPES+=	bad_type bad-type:bad_header.h
MKC_CHECK_TYPES+=	time_t:stddef.h,time.h

vars              :=	${MKC_CHECK_TYPES:C/:.*,/:/:S,/,_,g:S/.h/_h/g:S/:/./g:S/^/HAVE_TYPE./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
