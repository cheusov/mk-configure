# Copyright (c) 2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_MACRO_MK
_MKC_IMP_F_MACRO_MK := 1

.for f in noreturn pure printflike const always_inline aligned
MKC_CHECK_CUSTOM             +=	attribute_${f}
MKC_CUSTOM_FN.attribute_${f}  =	${FEATURESDIR}/macro/mkc_attribute_${f}.c
.endfor

.include <mkc.conf.mk>

CPPFLAGS +=	-D_MKC_CHECK_MACRO

.for f in noreturn pure printflike const always_inline aligned
.  if ${CUSTOM.attribute_${f}:U} != 1
MKC_CPPFLAGS +=	-DHAVE_NO_ATTR_${f:tu}
.  endif
.endfor

.endif # _MKC_IMP_F_MACRO_MK
