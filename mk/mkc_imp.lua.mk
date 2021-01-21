# Copyright (c) 2010 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.for i in ${LUA_LMODULES}
LUA_MODULES       +=	${i:T:R}
LUA_SRCS.${i:T:R}  =	${i}
.endfor

.if defined(LUA_MODULES) || defined(LUA_CMODULE)

#### .lua modules
.if defined(LUA_MODULES)
.if !defined(LUA_LMODDIR)
MKC_REQUIRE_PKGCONFIG +=	lua
PKG_CONFIG_VARS.lua   +=	INSTALL_LMOD
LUA_LMODDIR            =	${PKG_CONFIG.var.lua.INSTALL_LMOD}
.endif
.for i in ${LUA_MODULES}
LUA_SRCS.${i}       ?=	${i:S/./_/g}.lua
FILES               +=	${LUA_SRCS.${i}}
FILESDIR_${LUA_SRCS.${i}} =	${LUA_LMODDIR}/${i:S|.|/|g:H}
FILESNAME_${LUA_SRCS.${i}} =	${i:S|.|/|g:T}.lua
.endfor # i
.endif # defined(LUA_MODULES)

### .c module
.if defined(LUA_CMODULE)
MKC_REQUIRE_PKGCONFIG     +=	lua

.if !defined(LUA_CMODDIR)
PKG_CONFIG_VARS.lua +=	INSTALL_CMOD
LUA_CMODDIR         ?=	${PKG_CONFIG.var.lua.INSTALL_CMOD}
.endif
LIB        =		${LUA_CMODULE:S|.|/|:T}
SRCS      ?=		${LUA_CMODULE:S/./_/g}.c
MKDLL      =		Only
DLL_EXT    =		.so
LIBDIR     =		${LUA_CMODDIR}/${LUA_CMODULE:S|.|/|g:H}
.endif # defined(LUA_CMODULES)

######################
.include "mkc_imp.pkg-config.mk"

.if defined(LUA_MODULES) && empty(LUA_LMODDIR)
MKC_ERR_MSG  +=	"ERROR: pkg-config --variable=INSTALL_LMOD lua failed"
.endif # LUA_MODULES

.ifdef LUA_CMODULE
.if empty(LUA_CMODDIR)
MKC_ERR_MSG  +=	"ERROR: pkg-config --variable=INSTALL_CMOD lua failed"
.endif

.if empty(MKC_ERR_MSG)
MKC_REQUIRE_HEADERS +=	lua.h
.endif # !empty(MKC_ERR_MSG)
.endif # LUA_CMODULE

.endif # LUA_MODULES) || LUA_CMODULE
