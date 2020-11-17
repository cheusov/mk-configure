FOREIGN =		autotools
FSRCDIR =		proj

AT_USE_AUTOMAKE =	no
AT_MAKE         =	${BUILTIN.prog_gmake}

MKC_REQUIRE_BUILTINS =	prog_gmake
MKCHECKS           =	yes # we need path to gmake for target "clean"

# The following line is for regression tests.
# In real life we don't need this.
all: mkgen

.include "test.mk"
.include <mkc.mk>
