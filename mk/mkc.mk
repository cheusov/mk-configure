# Copyright (c) 2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_MK
_MKC_MK := 1

init_make_level ?= 0
.if defined(TOPDIR) && ${TOPDIR:U} != ${.CURDIR} && ${.MAKE.LEVEL} == ${init_make_level}
MKC_CACHEDIR ?=	${TOPDIR}
.export MKC_CACHEDIR
.MAIN: all
.DEFAULT:
	@set -e; cd ${TOPDIR}; pwd; ${MAKE} ${MAKEFLAGS} ${.TARGET}-${.CURDIR:T}
.else
.include <mkc_imp.mk>
.endif #TOPDIR

.endif # _MKC_MK
