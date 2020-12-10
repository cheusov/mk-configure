# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_STRLCPY_MK
_MKC_IMP_F_STRLCPY_MK := 1

MKC_CHECK_FUNCLIBS       +=	strlcpy
MKC_CHECK_FUNCS3         +=	strlcpy:string.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.strlcpy:U} != 1
MKC_SRCS +=	${FEATURESDIR}/strlcpy/mkc_strlcpy.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_STRLCPY

.endif #_MKC_IMP_F_STRLCPY_MK
