# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_HUMANIZE_NUMBER_MK
_MKC_IMP_F_HUMANIZE_NUMBER_MK := 1

MKC_CHECK_FUNCS2   +=	dehumanize_number:stdlib.h
MKC_CHECK_FUNCS6   +=	humanize_number:stdlib.h
MKC_CHECK_FUNCLIBS +=	humanize_number #dehumanize_number

.include <mkc.conf.mk>

. if ${HAVE_FUNCLIB.humanize_number:U} != 1 #|| ${HAVE_FUNCLIB.dehumanize_number:U} != 1
.   include "mkc_imp.f_macro.mk"
MKC_SRCS +=	${FEATURESDIR}/humanize_number/mkc_humanize_number.c
. endif

CPPFLAGS +=	-D_MKC_CHECK_HUMANIZE_NUMBER

.endif #_MKC_IMP_F_HUMANIZE_NUMBER_MK
