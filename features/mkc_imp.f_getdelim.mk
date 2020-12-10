# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_GETDELIM_MK
_MKC_IMP_F_GETDELIM_MK := 1

MKC_CHECK_FUNCLIBS +=	getdelim
MKC_CHECK_FUNCS4   +=	getdelim:stdio.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.getdelim:U} != 1
MKC_SRCS  +=	${FEATURESDIR}/getdelim/mkc_getdelim.c
.endif

CPPFLAGS  +=	-D_MKC_CHECK_GETDELIM

.endif #_MKC_IMP_F_GETDELIM_MK
