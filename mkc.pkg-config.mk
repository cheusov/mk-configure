# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

################### THIS MODULE IS INCOMPLETE!!! #######################

#
# Sample of Makefile:
#    PKG_CONFIG_DEPS = glib-2.0
#    PROG            = main
#
#    CFLAGS+=		-DG_DISABLE_DEPRECATED=1
#    CFLAGS+=		-DG_DISABLE_SINGLE_INCLUDES
#
#    .include <mkc.prog.mk>
#

########################################################################

.if !make(clean) && !make(cleandir) && !make(distclean) # .endif is in the end of file

MKC_REQUIRE_PROGS+=	pkg-config
.include <configure.mk>

.if ${HAVE_PROG.pkg-config}

.for l in ${PKG_CONFIG_DEPS}

PKG-CONFIG.module.exists !=	${PROG.pkg-config} --exists ${l}; echo $$?
.if ${PKG-CONFIG.module.exists} != 0
MKC_ERR_MSG=	"ERROR: pkg-config module ${l} cannot be found"
.else

.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l} !=	${PROG.pkg-config} --cflags ${l}
.endif # CPPFLAGS.pkg-config.${l}

.if !defined(LDADD.pkg-config.${l})
LDADD.pkg-config.${l}    !=	${PROG.pkg-config} --libs   ${l}
.endif # LDADD.pkg-config.${l}

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDADD+=		${LDADD.pkg-config.${l}}

.endif # PKG-CONFIG.module.exists

.endfor # .for l

.endif # HAVE_PROG.pkg-config

.endif # !make(clean) && !make(cleandir) && !make(distclean)
