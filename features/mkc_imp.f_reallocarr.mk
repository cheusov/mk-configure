# Copyright (c) 2021 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_REALLOCARR_MK
_MKC_IMP_F_REALLOCARR_MK := 1

MKC_CHECK_FUNCS3   +=	reallocarr:stdlib.h
MKC_CHECK_FUNCLIBS +=	reallocarr

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.reallocarr:U} != 1
MKC_SRCS +=	${FEATURESDIR}/reallocarr/mkc_reallocarr.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_REALLOCARR

.endif #_MKC_IMP_F_REALLOCARR_MK
