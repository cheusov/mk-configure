.ifndef PKG-CONFIG.exists
# Solaris has broken which(1). This is why I use pkg-config --help
PKG-CONFIG.exists!=	pkg-config --help > /dev/null; echo $$?
.endif

.if ${PKG-CONFIG.exists} != 0
MKC_ERR_MSG=		pkg-config is not available!
.else

.for l in ${PKG_CONFIG_DEPS}

PKG-CONFIG.module.exists !=	pkg-config --exists ${l}; echo $$?
.if ${PKG-CONFIG.module.exists} != 0
MKC_ERR_MSG=	pkg-config module ${l} is not available
.else

.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l} !=	pkg-config --cflags ${l}
.endif

.if !defined(LDADD.pkg-config.${l})
LDADD.pkg-config.${l}     != pkg-config --libs   ${l}
.endif

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDADD+=		${LDADD.pkg-config.${l}}

.endif # .if ${PKG-CONFIG.module.exists}...

.endfor # .for l

.endif # .if ${PKG-CONFIG.exists}...
