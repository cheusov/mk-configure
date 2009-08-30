MKC_REQUIRE_PROGS+=	pkg-config

.if !defined(PROG.pkg-config)
MKC_CACHEDIR?=${.OBJDIR}
MKC_NOCACHE?=
MKC_DELETE_TMPFILES?=0
MKC_SHOW_CACHED?=1
PROG.pkg-config   !=   	env MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1 mkc_check_prog pkg-config
DISTCLEANFILES+=	${MKC_CACHEDIR}/_mkc_*
.endif # !defined(PROG.pkg-config)

.if !empty(PROG.pkg-config)

.for l in ${PKG_CONFIG_DEPS}

PKG-CONFIG.module.exists !=	pkg-config --exists ${l}; echo $$?
.if ${PKG-CONFIG.module.exists} != 0
MKC_ERR_MSG=	"ERROR: pkg-config module ${l} cannot be found"
.else

.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l} !=	pkg-config --cflags ${l}
.endif

.if !defined(LDADD.pkg-config.${l})
LDADD.pkg-config.${l}    !=	pkg-config --libs   ${l}
.endif

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDADD+=		${LDADD.pkg-config.${l}}

.endif # module exists

.endfor # .for l

.endif # PROG.pkg-config
