# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP.F_PROGNAME_MK
_MKC_IMP.F_PROGNAME_MK := 1

MKC_COMMON_DEFINES      +=	-D_GNU_SOURCE

MKC_CHECK_FUNCLIBS      +=	getprogname setprogname 
MKC_CHECK_FUNCS0        +=	getprogname:stdlib.h getexecname:stdlib.h
MKC_CHECK_FUNCS1        +=	setprogname:stdlib.h
MKC_CHECK_VARS          +=	program_invocation_short_name:errno.h

.include <mkc.conf.mk>

.if !${HAVE_FUNCLIB.getprogname:U0} || !${HAVE_FUNCLIB.setprogname:U0}
MKC_SRCS +=	${FEATURESDIR}/progname/mkc_progname.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_PROGNAME

.endif # _MKC_IMP.F_PROGNAME_MK
