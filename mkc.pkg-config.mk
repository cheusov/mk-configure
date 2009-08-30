########################################################################

################### THIS MODULE IS INCOMPLETE!!! #######################

########################################################################

MKC_REQUIRE_PROGS+=	pkg-config
DISTCLEANFILES+=	${MKC_CACHEDIR}/_mkc_*

# begin of hack. FIX ME!!!
MKC_CACHEDIR?=${.OBJDIR}
MKC_NOCACHE?=
MKC_DELETE_TMPFILES?=0
MKC_SHOW_CACHED?=1
.if !defined(PROG.pkg-config)
PROG.pkg-config   !=   	env MKC_CACHEDIR='${MKC_CACHEDIR}' MKC_DELETE_TMPFILES='${MKC_DELETE_TMPFILES}' MKC_SHOW_CACHED='${MKC_SHOW_CACHED}' MKC_NOCACHE='${MKC_NOCACHE}' MKC_VERBOSE=1 mkc_check_prog pkg-config
.endif # !defined(PROG.pkg-config)
# end of hack

.if !make(clean) && !make(cleandir) && !make(distclean) # .endif is in the end of file

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

.endif # !make(clean) && !make(distclean)
