LUA_LMODULES =	foo.lua bar.lua
INSCRIPTS    =	foobar
SCRIPTS      =	${INSCRIPTS}

MKC_CHECK_PROGS =	lua

INTEXTS_REPLS   =	LUA ${PROG.lua:U}

.include "test.mk"
.include <mkc.prog.mk>
