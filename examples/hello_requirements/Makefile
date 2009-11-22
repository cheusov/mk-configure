PROG=		hello_reqs

MKC_REQUIRE_HEADERS+=	foobar.h string.h unistd.h
MKC_REQUIRE_FUNCLIBS+=	strcasecmp foobar barbaz:z
MKC_REQUIRE_DEFINES+=	FOOBAR
MKC_REQUIRE_TYPES+=	long size_t:string.h foobar_t barbaz:string.h
MKC_REQUIRE_VARS+=	errno:errno.h foobar_var barbaz:unistd.h
MKC_REQUIRE_MEMBERS+=	struct-tm.tm_isdst:time.h
MKC_REQUIRE_MEMBERS+=	struct-bad.member:stdlib.h
MKC_REQUIRE_FUNCS2+=	strcmp:string.h foobar:stdlib.h
MKC_REQUIRE_FUNCS9+=	barbaz
MKC_REQUIRE_PROGS+=	sh awk foobar_prog
MKC_REQUIRE_CUSTOM+=	custom_check1 custom_check2

MKC_REQD=		0.11.0

.include "test.mk"
.include <mkc.configure.mk>
.include <mkc.prog.mk>
