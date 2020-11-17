PROG    =	prog1
SCRIPTS =	prog1.sh ${INSCRIPTS}
INSCRIPTS =	prog1.awk

WARNS   =	4

MKC_REQUIRE_PROGS =	awk
INTEXTS_REPLS     =	AWK ${PROG.awk}

# Do not set SCRIPTSNAME in project's Makefile!
# This is just a regression test.
SCRIPTSNAME_prog1.awk =	program1.awk
SCRIPTSNAME_prog1.sh  =	program1.sh

SCRIPTSDIR_prog1.sh   =	${PREFIX}/libexec

.include "test.mk"
.include <mkc.prog.mk>
