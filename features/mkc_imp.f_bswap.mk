# Copyright (c) 2017 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_BSWAP_MK
_MKC_IMP_F_BSWAP_MK := 1

MKC_CHECK_FUNCS1   +=	bswap16:sys/endian.h \
			bswap32:sys/endian.h \
			bswap64:sys/endian.h \
			bswap_16:byteswap.h \
			bswap_32:byteswap.h \
			bswap_64:byteswap.h

MKC_FUNC_OR_DEFINE.bswap16 =	yes
MKC_FUNC_OR_DEFINE.bswap32 =	yes
MKC_FUNC_OR_DEFINE.bswap64 =	yes
MKC_FUNC_OR_DEFINE.bswap_16 =	yes
MKC_FUNC_OR_DEFINE.bswap_32 =	yes
MKC_FUNC_OR_DEFINE.bswap_64 =	yes

.include <mkc.conf.mk>

CPPFLAGS +=	-D_MKC_CHECK_BSWAP

.endif #_MKC_IMP_F_BSWAP_MK
