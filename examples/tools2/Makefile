SUBPRJ  = libs/foo:tools/prog1
SUBPRJ += libs/bar:tools/prog2
SUBPRJ += libs/foo:tools/prog3 libs/bar:tools/prog3
SUBPRJ += libs/qux:tools/prog4

SUBPRJ += tools/prog1:tests/prog1
SUBPRJ += tools/prog2:tests/prog2
SUBPRJ += tools/prog3:tests/prog3
SUBPRJ += tools/prog4:tests/prog4

NODEPS +=	check-*/*:check-*/* \
		all-tests/*:all \
		check-libs/*:check check-tools/*:check

# target "check" is used for testing because "test" is used by mk-configure
TARGETS =	check

SHORTPRJNAME =	no

# for regression test only
MKC_CACHEDIR =	${.OBJDIR}
_THISDIR_ =
.export _THISDIR_

.include "test.mk"
.include <mkc.subprj.mk>
