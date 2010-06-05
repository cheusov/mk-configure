# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

################### THIS MODULE IS INCOMPLETE!!! #######################

#
# Sample of Makefile:
#    PKG_CONFIG_DEPS                 = glib-2.0>=2.22
#
#    PROG            = main
#
#    CFLAGS+=		-DG_DISABLE_DEPRECATED=1
#    CFLAGS+=		-DG_DISABLE_SINGLE_INCLUDES
#
#    .include <mkc.prog.mk>
#

########################################################################

# .endif for the next line is in the end of file
.if defined(PKG_CONFIG_DEPS) && !make(clean) && !make(cleandir) && !make(distclean)

MKC_REQUIRE_PROGS+=	pkg-config
.include <configure.mk>

.if ${HAVE_PROG.pkg-config}

.for l in ${PKG_CONFIG_DEPS}
#_ln := ${l:C/[><=].*$//}
_lp := ${l:C/(>=|<=|=|>|<)/ & /g}
PKG_CONFIG.exists != echo ok; ${PROG.pkg-config} --print-errors --exists "${_lp}" 2>&1 | sed -e "s/'//g" -eq

.if ${PKG_CONFIG.exists} != "ok"
MKC_ERR_MSG+="ERROR: ${PKG_CONFIG.exists:[2..-1]}"
.else

.if !defined(CPPFLAGS.pkg-config.${_ln})
CPPFLAGS.pkg-config.${_ln} !=	${PROG.pkg-config} --cflags '${_lp}'
.endif # CPPFLAGS.pkg-config.${l}

.if !defined(LDADD.pkg-config.${_ln})
LDADD.pkg-config.${_ln}    !=	${PROG.pkg-config} --libs '${_lp}'
.endif # LDADD.pkg-config.${l}

CPPFLAGS+=	${CPPFLAGS.pkg-config.${_ln}}
LDADD+=		${LDADD.pkg-config.${_ln}}

.endif # PKG-CONFIG.module.exists

.endfor # .for l

.undef _ln
.undef _lp

.endif # HAVE_PROG.pkg-config

.endif # !make(clean) && !make(cleandir) && !make(distclean)
