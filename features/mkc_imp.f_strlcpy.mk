# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_STRLCPY_MK
_MKC_IMP_F_STRLCPY_MK := 1

MKC_SOURCE_FUNCLIBS      +=	strlcpy
MKC_SOURCE_DIR.strlcpy.c  =	${FEATURESDIR}/strlcpy
MKC_CHECK_FUNCS3         +=	strlcpy:string.h

.endif #_MKC_IMP_F_STRLCPY_MK
