# Copyright (c) 2013 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_MK
_MKC_MK := 1

init_make_level ?= 0

.if defined(SRCTOP) && ${SRCTOP:U} != ${.CURDIR} && ${.MAKE.LEVEL} == ${init_make_level}
MKC_CACHEDIR ?=	${SRCTOP}
.export MKC_CACHEDIR
.MAIN: all
.DEFAULT:
	@set -e; cd ${SRCTOP}; ${MAKE} ${MAKEFLAGS} ${.TARGET}-${.CURDIR:S,${SRCTOP}/,,}
.else
.include <mkc_imp.mk>
.endif #SRCTOP

.endif # _MKC_MK
