#include <lua.h>

static int baz (lua_State *L)
{
	lua_pushstring(L, "baz");
	return 1;
}

int luaopen_baz (lua_State *L)
{
	lua_register(L, "baz", baz);
	return 0;
}
