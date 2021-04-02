# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_SHQUOTE_MK
_MKC_IMP_F_SHQUOTE_MK := 1

.include "mkc_imp.f_macro.mk"

MKC_CHECK_FUNCLIBS      +=	shquote
MKC_CHECK_FUNCS3        +=	shquote:stdlib.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.shquote:U} != 1
MKC_SRCS +=	${FEATURESDIR}/shquote/mkc_shquote.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_SHQUOTE

.endif # _MKC_IMP_F_SHQUOTE_MK
