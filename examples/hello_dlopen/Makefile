MKC_CHECK_FUNCLIBS+=	dlopen:dl

PROG=			dlopen_test

MKMAN=			no

.if exists(/lib/libc.so)
LIBC_FN=		/lib/libc.so
.elif
LIBC_FN!=		echo /lib/libc.so* | cut -d ' ' -f1
.endif

CPPFLAGS+=		-DLIBC_FN='"${LIBC_FN}"'

.include "test.mk"
.include <mkc.configure.mk>
.include <mkc.prog.mk>
