# Copyright (c) 2017 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_POSIX_GETOPT_MK
_MKC_IMP_F_POSIX_GETOPT_MK := 1

MKC_CHECK_DEFINES   +=	__GLIBC__:string.h

.include <mkc.conf.mk>

.if ${HAVE_DEFINE.__GLIBC__.string_h:U1} == 1
.include "mkc_imp.f_efun.mk"
MKC_SRCS     +=	${FEATURESDIR}/posix_getopt/mkc_posix_getopt.c
.else
CPPFLAGS +=	-DHAVE_POSIX_GETOPT=1
.endif

CPPFLAGS +=	-D_MKC_CHECK_POSIX_GETOPT

.endif #_MKC_IMP_F_POSIX_GETOPT_MK
