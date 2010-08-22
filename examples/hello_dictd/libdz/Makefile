# library that implements compression routines for dict.dz format

LIB=		dz
SRCS=		dz.c

WARNS=		4

EXPORT_SYMBOLS=		export.sym

MKC_REQUIRE_HEADERS=	zlib.h
MKC_REQUIRE_FUNCLIBS=	deflate:z

SHLIB_MAJOR=	1
SHLIB_MINOR=	0

.include <mkc.lib.mk>
