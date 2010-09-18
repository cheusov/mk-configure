# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

# .endif for the next line is in the end of file
.if defined(LUA_LMODULES) || defined(LUA_CMODULE)

PKG_CONFIG_DEPS+=	lua

#### .lua modules
.if defined(LUA_LMODULES)
.if !defined(LUA_LMODDIR)
PKG_CONFIG_VARS.lua+=	INSTALL_LMOD
LUA_LMODDIR?=		${PKG_CONFIG.var.lua.INSTALL_LMOD}
.endif
FILES+=			${LUA_LMODULES}
.for i in ${LUA_LMODULES}
FILESDIR_${i}=	${LUA_LMODDIR}
.endfor # i
.endif # defined(LUA_LMODULES)

### .c module
.if defined(LUA_CMODULE)
.if !defined(LUA_CMODDIR)
PKG_CONFIG_VARS.lua+=	INSTALL_CMOD
LUA_CMODDIR?=		${PKG_CONFIG.var.lua.INSTALL_CMOD}
.endif
LIB=			${LUA_CMODULE}
SRCS?=			${LUA_CMODULE}.c
MKDLL=			Only
LDCOMPILER=		Yes
DLL_EXT=		.so
LIBDIR=			${LUA_CMODDIR}
.endif # defined(LUA_LMODULES)

######################
.include <mkc_imp.pkg-config.mk>

.if defined(LUA_LMODULES) && empty(LUA_LMODDIR)
MKC_ERR_MSG+=	"ERROR: pkg-config --variable=INSTALL_LMOD lua failed"
.endif # LUA_LMODULES

.ifdef LUA_CMODULE
.if empty(LUA_CMODDIR)
MKC_ERR_MSG+=	"ERROR: pkg-config --variable=INSTALL_CMOD lua failed"
.endif

.if empty(MKC_ERR_MSG)
MKC_REQUIRE_HEADERS+=	lua.h
.endif # !empty(MKC_ERR_MSG)
.endif # LUA_CMODULE

.endif # LUA_LMODULES) || LUA_CMODULE
