LIB=	hello2
SRCS=	hello2.cc

INCS!=	echo include/*.h

MKINSTALL?=	no # do not install this library

MKPIC=	no

CPPFLAGS+=	-I${.CURDIR}/include
CFLAGS+=	-DHELLO_VERSION='"${VERSION}"'

.include "../version.mk"

.include <mkc.lib.mk>
