# Copyright (c) 2021 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_STRTOI_MK
_MKC_IMP_F_STRTOI_MK := 1

MKC_CHECK_FUNCS6   +=	strtoi:inttypes.h
MKC_CHECK_FUNCLIBS +=	strtoi

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.strtoi:U} != 1
MKC_SRCS +=	${FEATURESDIR}/strto/mkc_strtoi.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_STRTOI

.endif #_MKC_IMP_F_STRTOI_MK
