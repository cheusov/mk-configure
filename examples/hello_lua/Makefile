PROJECTNAME =	hello_lua

LUA_LMODULES =	foo.lua bar.lua
LUA_CMODULE  =	baz

INSCRIPTS =	foobar
SCRIPTS   =	${INSCRIPTS}

INTEXTS_REPLS   =	LUA ${PROG.lua}
MKC_CHECK_PROGS =	lua

.include "test.mk"
.include <mkc.lib.mk>
