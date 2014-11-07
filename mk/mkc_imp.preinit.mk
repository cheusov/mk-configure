# Copyright (c) 2010 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP.PREINIT.MK
 _MKC_IMP.PREINIT.MK:=1

####################
BMAKE_REQD ?=	20110606

.ifdef MAKE_VERSION
_bmake_ok != test ${MAKE_VERSION} -ge ${BMAKE_REQD} && echo 1 || echo 0
.else
_bmake_ok  = 0
.endif

.if !${_bmake_ok}
.error "bmake-${BMAKE_REQD} or newer is required"
.endif

.ifdef _top_mk
.for i in SUBDIR SUBPRJ PROG LIB
.if defined(${i}) && ${_top_mk} != "mkc.${i:tl}.mk"
.error "${i} is not allowed for ${_top_mk}"
.endif
.endfor
.endif

####################
.if !make(clean) && !make(cleandir) && !make(distclean) && !make(obj)
MKCHECKS ?=	yes
.else
MKCHECKS ?=	no
.endif # clean/cleandir/distclean

.endif # _MKC_IMP.PREINIT.MK
