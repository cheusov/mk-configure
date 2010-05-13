LIB=	hello2
SRCS=	hello2.cc
MAN=	hello2.1

INCS!=	echo include/*.h

MKINSTALL?=	no # This is internal library, do not install it.

CPPFLAGS+=	-I${.CURDIR}/include
CFLAGS+=	-DHELLO_VERSION='"${VERSION}"'

.include "../version.mk"

.include <mkc.lib.mk>
