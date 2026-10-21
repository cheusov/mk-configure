MKC_CHECK_MEMBERS+=	struct-tm.tm_isdst:string.h,time.h
MKC_CHECK_MEMBERS+=	struct-sockaddr_in.sin_addr.s_addr:arpa/inet.h,netinet/in.h
MKC_CHECK_MEMBERS+=	bad.member
MKC_CHECK_MEMBERS+=	bad.member:string.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.a:include/mkc_test.h
MKC_CHECK_MEMBERS+=	struct-mkc_test_t.b.c:include/mkc_test.h

CPPFLAGS      +=	-I..

vars              :=	${MKC_CHECK_MEMBERS:C/:.*,/:/:S,/,_,g:S,-,_,g:S/./_/g:S/:/./g:S/^/HAVE_MEMBER./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
