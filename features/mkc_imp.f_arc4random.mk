# Copyright (c) 2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_ARC4RANDOM_MK
_MKC_IMP_F_ARC4RANDOM_MK := 1

MKC_CHECK_FUNCLIBS +=	arc4random
MKC_CHECK_FUNCS0   +=	arc4random:stdlib.h

.include <mkc.conf.mk>

. if ${HAVE_FUNCLIB.arc4random:U0} != 1
MKC_SRCS +=	${FEATURESDIR}/arc4random/arc4random.c
. endif

CPPFLAGS +=	-D_MKC_CHECK_ARC4RANDOM

.endif #_MKC_IMP_F_ARC4RANDOM_MK
