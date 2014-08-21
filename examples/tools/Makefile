LIBDEPS  = libs/foo:tools/prog1
LIBDEPS += libs/bar:tools/prog2
LIBDEPS += libs/foo:tools/prog3 libs/bar:tools/prog3
LIBDEPS += libs/qux:tools/prog4

# target "check" is used for testing because "test" is used by mk-configure
TARGETS = check

NODEPS +=	check-libs/*:check check-libs/*:check-tools/*

# for regression test only
_THISDIR_ =
.export _THISDIR_

.include "test.mk"
.include <mkc.subprj.mk>
