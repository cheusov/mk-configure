MKC_CHECK_SIZEOF+=	int long-long void* size_t:stdlib.h,unistd.h,string.h
MKC_CHECK_SIZEOF+=	bad_type bad-type:bad_header.h

vars              :=	${MKC_CHECK_SIZEOF:C/:.*,/:/:S,/,_,g:S/.h/_h/g:S/*/P/g:S/-/_/g:S/:/./g:S/^/SIZEOF./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
