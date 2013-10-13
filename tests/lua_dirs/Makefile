LUA_LMODDIR=	${PREFIX}/share/luamods_l
LUA_CMODDIR=	${PREFIX}/lib/luamods_c

LUA_LMODULES=	../../examples/hello_lua/foo.lua
LUA_LMODULES+=	../../examples/hello_lua/bar.lua
LUA_CMODULE=	baz

SCRIPTS   =	${INSCRIPTS:T}
INSCRIPTS=	../../examples/hello_lua/foobar

.include <mkc.lib.mk>
.include "test.mk"
