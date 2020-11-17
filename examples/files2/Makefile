PROG =		hello_world1
SRCS =		main.c msg.c

WARNS =		4

INSCRIPTS =	hello_world3
SCRIPTS  =	hello_world2 ${INSCRIPTS}
SCRIPTS +=	${:!echo more_scripts/*!:N*/CVS}

SCRIPTSDIR_more_scripts_script1 =	${BINDIR}/subdir1

SCRIPTSNAME_more_scripts_script2 =	myscript2

SCRIPTSDIR_more_scripts_script3  =	${BINDIR}/subdir3
SCRIPTSNAME_more_scripts_script3 =	myscript3

MKC_REQUIRE_PROGS =	awk
INTEXTS_REPLS     =	AWK ${PROG.awk}

MAN =		hello_world.1

MKC_REQD =	0.10.0

.include "test.mk"
.include <mkc.prog.mk>
