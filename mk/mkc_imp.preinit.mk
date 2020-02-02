# Copyright (c) 2010 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP.PREINIT.MK
 _MKC_IMP.PREINIT.MK:=1

####################
BMAKE_REQD ?=	20110606

.if !empty(MAKE_VERSION:U)
_bmake_ok != test ${MAKE_VERSION:Q} -ge ${BMAKE_REQD:Q} && echo 1 || echo 0
.else
.error "bmake does not provide MAKE_VERSION variable"
.endif

.if !${_bmake_ok}
.error "bmake-${BMAKE_REQD} or newer is required, but bmake-${MAKE_VERSION} is provided"
.endif

.ifdef _top_mk
.for i in SUBDIR SUBPRJ PROG LIB
.if defined(${i}) && ${_top_mk} != "mkc.${i:tl}.mk"
.error "${i} is not allowed for ${_top_mk}"
.endif
.endfor
.endif

####################
.if !make(clean) && !make(cleandir) && !make(distclean) && !make(obj) && !make(help)
MKCHECKS ?=	yes
.else
MKCHECKS ?=	no
.endif # clean/cleandir/distclean

.if !empty(MK_C_PROJECT)
.sinclude <newsys.mk> # .sinclude for bootstrapping
.endif

.endif # _MKC_IMP.PREINIT.MK
