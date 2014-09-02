LIBDEPS  =	libcommon:dict
LIBDEPS +=	libcommon:dictd
LIBDEPS +=	libcommon:dictzip
LIBDEPS +=	libcommon:dictfmt
LIBDEPS +=	libmaa:dict
LIBDEPS +=	libmaa:dictd
LIBDEPS +=	libmaa:dictzip
LIBDEPS +=	libmaa:dictfmt
LIBDEPS +=	libdz:dictzip

STATICLIBS +=	libcommon

# Subproject "doc" has no dependencies
SUBPRJ +=	doc
# and is not built by default
SUBPRJ_DFLT =	dict dictd dictzip dictfmt

.include "test.mk"
.include <mkc.subprj.mk>
