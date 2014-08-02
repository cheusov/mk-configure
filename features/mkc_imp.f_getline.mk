# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP.F_GETLINE_MK
_MKC_IMP.F_GETLINE_MK := 1

MKC_SOURCE_FUNCLIBS      +=	getline
MKC_SOURCE_DIR.getline.c  =	${FEATURESDIR}/getline
MKC_CHECK_FUNCS3         +=	getline:stdio.h

.endif # _MKC_IMP.F_GETLINE_MK
