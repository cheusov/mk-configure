# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP.F_FGETLN_MK
_MKC_IMP.F_FGETLN_MK := 1

.include <mkc_imp.f_getline.mk>

MKC_CHECK_FUNCLIBS      +=	fgetln
MKC_CHECK_FUNCS2         +=	fgetln:stdio.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.fgetln:U} != 1
MKC_SRCS +=	${FEATURESDIR}/fgetln/mkc_fgetln.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_FGETLN

.endif # _MKC_IMP.F_FGETLN_MK
