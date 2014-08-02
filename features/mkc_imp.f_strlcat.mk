# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_STRLCAT_MK
_MKC_IMP_F_STRLCAT_MK := 1

MKC_SOURCE_FUNCLIBS      +=	strlcat
MKC_SOURCE_DIR.strlcat.c  =	${FEATURESDIR}/strlcat
MKC_CHECK_FUNCS3         +=	strlcat:string.h

.endif # _MKC_IMP_F_STRLCAT_MK
