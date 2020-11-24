# Copyright (c) 2020 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP.F_ARC4RANDOM_MK
_MKC_IMP.F_ARC4RANDOM_MK := 1

MKC_CHECK_FUNCS0   +=	arc4random:stdlib.h arc4random_stir:stdlib.h
MKC_CHECK_FUNCS1   +=	arc4random_uniform:stdlib.h
MKC_CHECK_FUNCS2   +=	arc4random_buf:stdlib.h arc4random_addrandom:stdlib.h

MKC_REQUIRE_FUNCLIBS +=	arc4random:bsd arc4random_buf:bsd arc4random_uniform:bsd
#MKC_REQUIRE_FUNCLIBS +=	arc4random_stir:bsd arc4random_addrandom:bsd

.include <mkc.conf.mk>

CPPFLAGS +=	-D_MKC_CHECK_ARC4RANDOM

.endif # _MKC_IMP.F_ARC4RANDOM_MK
