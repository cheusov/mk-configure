# Copyright (c) 2017 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_FPARSELN_MK
_MKC_IMP_F_FPARSELN_MK := 1

.include "mkc_imp.f_getline.mk"

MKC_CHECK_FUNCLIBS +=	fparseln
MKC_CHECK_FUNCS5   +=	fparseln:stdio.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.fparseln:U} != 1
MKC_SRCS +=	${FEATURESDIR}/fparseln/fparseln.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_FPARSELN

.endif #_MKC_IMP_F_FPARSELN_MK
