# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP.F_GETLINE_MK
_MKC_IMP.F_GETLINE_MK := 1

MKC_CHECK_FUNCLIBS      +=	getline
MKC_CHECK_FUNCS3        +=	getline:stdio.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.getline:U} != 1
MKC_SRCS +=	${FEATURESDIR}/getline/mkc_getline.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_GETLINE

.endif # _MKC_IMP.F_GETLINE_MK
