# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

# .endif for the next line is in the end of file
.if !make(clean) && !make(cleandir) && !make(distclean)
.if defined(LUA_LMODULES) || defined(LUA_CMODULE)

PKG_CONFIG_DEPS+=	lua

.if defined(LUA_LMODULES)
PKG_CONFIG_VARS.lua+=	INSTALL_LMOD
FILES+=			${LUA_LMODULES}
.for i in ${LUA_LMODULES}
FILESDIR_${i}=	${PKG_CONFIG.var.lua.INSTALL_LMOD}
.endfor
.endif

.if defined(LUA_CMODULE)
PKG_CONFIG_VARS.lua+=	INSTALL_CMOD
LIB=			${LUA_CMODULE}
SRCS?=			${LUA_CMODULE}.c
MKSTATICLIB=		no
SHLIB_MAJOR=		1
SHLIB_MINOR=		0
MKSHLIB=		Yes
MKDLL=			Yes
LDCOMPILER=		Yes
LIBDIR=			${PKG_CONFIG.var.lua.INSTALL_CMOD}
.endif

.include <mkc_imp.pkg-config.mk>

.if !empty(MKC_ERR_MSG)

MKC_REQUIRE_HEADERS+=	lua.h

.endif # !empty(MKC_ERR_MSG)
.endif # LUA_LMODULES) || LUA_CMODULE
.endif # !make(clean) && !make(cleandir) && !make(distclean)
