PROG =			hello_glib2

MKC_REQUIRE_PKGCONFIG =	glib-2.0>=2.1

CFLAGS +=		-DG_DISABLE_DEPRECATED=1
CFLAGS +=		-DG_DISABLE_SINGLE_INCLUDES

MKC_REQD =		0.11.0

.include "test.mk"
.include <mkc.prog.mk>
