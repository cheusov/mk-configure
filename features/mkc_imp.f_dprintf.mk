# Copyright (c) 2018 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_DPRINTF_MK
_MKC_IMP_F_DPRINTF_MK := 1

MKC_CHECK_FUNCLIBS +=	dprintf vdprintf
MKC_CHECK_FUNCS3   +=	dprintf:stdio.h
MKC_CHECK_PROTOTYPES =	vdprintf
MKC_PROTOTYPE_FUNC.vdprintf =	int vdprintf(int, const char *, va_list);
MKC_PROTOTYPE_HEADERS.vdprintf +=	stdio.h stdarg.h

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.dprintf:U} != 1 || ${HAVE_PROTOTYPE.vdprintf:U} != 1
MKC_SRCS +=	${FEATURESDIR}/dprintf/mkc_dprintf.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_DPRINTF

.endif #_MKC_IMP_F_DPRINTF_MK
