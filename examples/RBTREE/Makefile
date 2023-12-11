PROG  =		hello_RBTREE

WARNS =		4

MKC_FEATURES  =	RB

MKC_REQD =	0.26.0

.include <mkc.init.mk>

CFLAGS.check	+=	-erroff=E_EMPTY_DECLARATION

.include "test.mk"
.include <mkc.prog.mk>
