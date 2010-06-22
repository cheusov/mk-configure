# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

# .endif for the next line is in the end of file
.if defined(LUA_LMODULES) || defined(LUA_CMODULE)

PKG_CONFIG_DEPS+=	lua

.if defined(LUA_LMODULES)
PKG_CONFIG_VARS.lua+=	INSTALL_LMOD
FILES+=			${LUA_LMODULES}
.for i in ${LUA_LMODULES}
FILESDIR_${i}=	${PKG_CONFIG.var.lua.INSTALL_LMOD}
.endfor # i
.endif # defined(LUA_LMODULES)

.if defined(LUA_CMODULE)
PKG_CONFIG_VARS.lua+=	INSTALL_CMOD
LIB=			${LUA_CMODULE}
SRCS?=			${LUA_CMODULE}.c
MKDLL=			Only
LDCOMPILER=		Yes
# The following Line is for Darwin
#SHLIB_EXT=		.so
LIBDIR=			${PKG_CONFIG.var.lua.INSTALL_CMOD}
.endif # defined(LUA_LMODULES)

.include <mkc_imp.pkg-config.mk>

.if empty(PKG_CONFIG.var.lua.INSTALL_LMOD)
MKC_ERR_MSG+=	"ERROR: pkg-config --variable=INSTALL_LMOD lua failed"
.endif

.if empty(PKG_CONFIG.var.lua.INSTALL_CMOD)
MKC_ERR_MSG+=	"ERROR: pkg-config --variable=INSTALL_CMOD lua failed"
.endif

.if empty(MKC_ERR_MSG)
MKC_REQUIRE_HEADERS+=	lua.h
.endif # !empty(MKC_ERR_MSG)

.endif # LUA_LMODULES) || LUA_CMODULE
