# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_STRNDUP_MK
_MKC_IMP_F_STRNDUP_MK := 1

MKC_CHECK_FUNCLIBS +=	strndup
MKC_CHECK_FUNCS2   +=	strndup:string.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.strndup:U} != 1
MKC_SRCS  +=	${FEATURESDIR}/strndup/mkc_strndup.c
.endif

CPPFLAGS  +=	-D_MKC_CHECK_STRNDUP

.endif #_MKC_IMP_F_STRNDUP_MK
