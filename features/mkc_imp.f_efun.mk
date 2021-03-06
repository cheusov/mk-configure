# Copyright (c) 2015 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_EFUN_MK
_MKC_IMP_EFUN_MK := 1

.include "mkc_imp.f_err.mk"
.include "mkc_imp.f_strlcpy.mk"
.include "mkc_imp.f_strlcat.mk"
.include "mkc_imp.f_strndup.mk"
.include "mkc_imp.f_reallocarr.mk"
.include "mkc_imp.f_strtoi.mk"
.include "mkc_imp.f_strtou.mk"

MKC_CHECK_FUNCS2   +=	ecalloc:util.h
MKC_CHECK_FUNCLIBS +=	ecalloc:util

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.ecalloc:U} != 1 && ${HAVE_FUNCLIB.ecalloc.util:U} != 1
MKC_SRCS +=	${FEATURESDIR}/efun/mkc_efun.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_EFUN

.endif #_MKC_IMP_EFUN_MK
