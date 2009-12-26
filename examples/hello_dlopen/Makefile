MKC_CHECK_FUNCLIBS+=	dlopen:dl

PROG=			dlopen_test

.include <mkc.own.mk>

.ifndef LIBC_FN
.if ${OPSYS} == "Interix"
LIBC_FN!=		echo /lib/libc.so.* | cut -d ' ' -f1
.else
.if exists(/lib/libc.so)
LIBC_FN=		/lib/libc.so
.else
LIBC_FN!=		echo /lib/libc.so* | cut -d ' ' -f1
.endif # exists...
.endif # ${OPSYS} test
.endif # .ifndef LIBC_FN

CPPFLAGS+=		-DLIBC_FN='"${LIBC_FN}"'

MKC_REQD=		0.10.0

.include "test.mk"
.include <mkc.prog.mk>
