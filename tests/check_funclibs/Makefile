MKC_CHECK_FUNCLIBS  +=	strcpy sqrt:m
MKC_CHECK_FUNCLIBS  +=	bad_func:bad_lib bad_func

MKC_SOURCE_FUNCLIBS +=	superfunc1
MKC_SOURCE_FUNCLIBS +=	superfunc2:superlib2

MKC_NOAUTO_FUNCLIBS +=	sqrt:m

vars                :=	${MKC_CHECK_FUNCLIBS:S/^/HAVE_FUNCLIB./g:S/:/./g}
vars                +=	v1 v2 v3

v1                  +=	${SRCS:M*superfunc1*:T}
v2                  +=	${SRCS:M*superfunc2*:T}
v3                  +=	${LDADD}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
