# Copyright (c) 2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_MACRO_MK
_MKC_IMP_F_MACRO_MK := 1

MKC_CHECK_CUSTOM                 +=	attribute_noreturn
MKC_CUSTOM_FN.attribute_noreturn  =	${FEATURESDIR}/macro/mkc_attribute_noreturn.c

.include <mkc.conf.mk>

CPPFLAGS +=	-D_MKC_CHECK_MACRO

.if ${CUSTOM.attribute_noreturn:U} != 1
MKC_CPPFLAGS +=	-DHAVE_NO_ATTR_NORETURN
.endif

.endif #_MKC_IMP_F_MACRO_MK
