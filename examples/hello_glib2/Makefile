PROG=			hello_glib2

MKC_REQUIRE_PROGS=	pkg-config

PKG_CONFIG_DEPS=	glib-2.0

CFLAGS+=		-DG_DISABLE_DEPRECATED=1
CFLAGS+=		-DG_DISABLE_SINGLE_INCLUDES

MKMAN=			no

.include "test.mk"

.include <mkc.configure.mk>
.include <mkc.pkg-config.mk>
.include <mkc.prog.mk>
