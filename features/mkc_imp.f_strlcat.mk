# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_STRLCAT_MK
_MKC_IMP_F_STRLCAT_MK := 1

MKC_CHECK_FUNCLIBS      +=	strlcat
MKC_CHECK_FUNCS3         +=	strlcat:string.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.strlcat:U} != 1
MKC_SRCS +=	${FEATURESDIR}/strlcat/mkc_strlcat.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_STRLCAT

.endif # _MKC_IMP_F_STRLCAT_MK
