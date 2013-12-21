SUBPRJ  = libs/foo:tools/prog1
SUBPRJ += libs/bar:tools/prog2
SUBPRJ += libs/foo:tools/prog3 libs/bar:tools/prog3
SUBPRJ += libs/qux:tools/prog4

TARGETS = check

NODEPS +=	check-libs/*:check check-libs/*:check-tools/*

# for regression test only
_THISDIR_ =
.export _THISDIR_

.include "test.mk"
.include <mkc.subprj.mk>
