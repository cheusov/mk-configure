# Copyright (c) 2021 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_STRTOU_MK
_MKC_IMP_F_STRTOU_MK := 1

MKC_CHECK_FUNCS6   +=	strtou:inttypes.h
MKC_CHECK_FUNCLIBS +=	strtou

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.strtou:U} != 1
MKC_SRCS +=	${FEATURESDIR}/strto/mkc_strtou.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_STRTOU

.endif #_MKC_IMP_F_STRTOU_MK
