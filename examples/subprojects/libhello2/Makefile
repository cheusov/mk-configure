LIB=	hello2
SRCS=	hello2.cc

MKPIC=	no

CPPFLAGS+=	-I${.CURDIR}/include
CFLAGS+=	-DHELLO_VERSION='"${VERSION}"'

.include "../version.mk"

.include <mkc.lib.mk>
