########################################################################

################### THIS MODULE IS INCOMPLETE!!! #######################

#
# In order to activate this module youn MUST:
#   1) Add
#        MKC_REQUIRE_PROGS += pkg-config
#      line before 
#        .include <mkc.configure.mk>
#      in Makefile
#   2) Write in
#        .include <mkc.pkg-config.mk>
#      after
#        .include <mkc.configure.mk>
#      in Makefile
#

########################################################################

MKC_REQUIRE_PROGS+=	pkg-config
DISTCLEANFILES+=	${MKC_CACHEDIR}/_mkc_*

.if !make(clean) && !make(cleandir) && !make(distclean) # .endif is in the end of file

.if defined(PROG.pkg-config)
.if !empty(PROG.pkg-config)

.for l in ${PKG_CONFIG_DEPS}

PKG-CONFIG.module.exists !=	pkg-config --exists ${l}; echo $$?
.if ${PKG-CONFIG.module.exists} != 0
MKC_ERR_MSG=	"ERROR: pkg-config module ${l} cannot be found"
.else

.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l} !=	pkg-config --cflags ${l}
.endif # CPPFLAGS.pkg-config.${l}

.if !defined(LDADD.pkg-config.${l})
LDADD.pkg-config.${l}    !=	pkg-config --libs   ${l}
.endif # LDADD.pkg-config.${l}

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDADD+=		${LDADD.pkg-config.${l}}

.endif # PKG-CONFIG.module.exists

.endfor # .for l

.endif # PROG.pkg-config

.else
MKC_ERR_MSG+= "ERROR: pkg-config is not initialized properly, read mkc.pkg-config.mk"
.endif #defined(PROG.pkg-config)

.endif # !make(clean) && !make(cleandir) && !make(distclean)
