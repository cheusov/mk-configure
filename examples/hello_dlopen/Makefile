MKC_CHECK_FUNCLIBS+=	dlopen:dl

PROG=			dlopen_test

.if exists(/lib/libc.so)
LIBC_FN=		/lib/libc.so
.else
LIBC_FN!=		echo /lib/libc.so* | cut -d ' ' -f1
.endif

CPPFLAGS+=		-DLIBC_FN='"${LIBC_FN}"'

MKC_REQD=		0.10.0

.include "test.mk"
.include <mkc.prog.mk>
