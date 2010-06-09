# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

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

############################################################

# .endif for the next line is in the end of file
.if defined(PKG_CONFIG_DEPS) && !make(clean) && !make(cleandir) && !make(distclean)

MKC_REQUIRE_PROGS+=	pkg-config
.include <configure.mk>

.if ${HAVE_PROG.pkg-config}

.for l in ${PKG_CONFIG_DEPS}
_lp= ${l:C/(>=|<=|=|>|<)/ & /g}
_ln= ${l:S/>=/_ge_/:S/>/_gt_/:S/<=/_le_/:S/</_lt_/}

PKG_CONFIG.exists != env ${mkc.environ} mkc_check_custom \
    -p pkgconfig -s -n ${_ln} -m '[pkg-config] ${_lp}' \
    ${PROG.pkg-config} --print-errors --exists "${_lp}"

.if !${PKG_CONFIG.exists}
MKC_ERR_MSG:= ${MKC_ERR_MSG} "%%%: ${MKC_CACHEDIR}/_mkc_pkgconfig_${_ln}.err"
.else

.if defined(PROG) || defined(LIB)
.if !defined(CPPFLAGS.pkg-config.${_ln})
CPPFLAGS.pkg-config.${_ln} !=	${PROG.pkg-config} --cflags '${_lp}'
.endif # CPPFLAGS.pkg-config.${l}

.if !defined(LDADD.pkg-config.${_ln})
LDADD.pkg-config.${_ln}    !=	${PROG.pkg-config} --libs '${_lp}'
.endif # LDADD.pkg-config.${l}
.endif # PROG || LIB

# _ln does not work in the following two lines :-(
CPPFLAGS+=	${CPPFLAGS.pkg-config.${l:S/>=/_ge_/:S/>/_gt_/:S/<=/_le_/:S/</_lt_/}}
LDADD+=		${LDADD.pkg-config.${l:S/>=/_ge_/:S/>/_gt_/:S/<=/_le_/:S/</_lt_/}}

.endif # PKG-CONFIG.module.exists

.endfor # .for l

.undef _ln
.undef _lp

.endif # HAVE_PROG.pkg-config

.endif # !make(clean) && !make(cleandir) && !make(distclean)
