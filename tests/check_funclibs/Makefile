MKC_CHECK_FUNCLIBS +=	strcpy sqrt:m
MKC_CHECK_FUNCLIBS +=	bad_func.bad_lib bad_func

vars          :=	${MKC_CHECK_FUNCLIBS:S/^/HAVE_FUNCLIB./g:S/:/./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
