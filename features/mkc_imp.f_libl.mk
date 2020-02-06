# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
.ifndef _MKC_IMP_F_LIBL_MK
_MKC_IMP_F_LIBL_MK := 1

MKC_CHECK_FUNCLIBS +=	yywrap:l

.include "mkc.conf.mk"

.if !${HAVE_FUNCLIB.yywrap.l:U0} && !${HAVE_FUNCLIB.yywrap:U0}
MKC_REQUIRE_FUNCLIBS +=	yywrap:fl
.endif

.endif #_MKC_IMP_F_LIBL_MK
