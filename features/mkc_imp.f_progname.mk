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
MKC_CHECK_VARS           +=	program_invocation_short_name:errno.h

.include <mkc_imp.conf-cleanup.mk>

.if ${HAVE_FUNCLIB.getprogname:U0} && \
    ${HAVE_FUNCLIB.setprogname:U0} && \
    ${HAVE_FUNC0.getprogname.stdlib_h:U0} && \
    ${HAVE_FUNC1.setprogname.stdlib_h:U0}
CFLAGS +=	-DMKC_PROGNAME_IS_FINE
.else
MKC_SRCS +=		${FEATURESDIR}/progname/progname.c
.endif

.include <mkc_imp.conf-final.mk>

.endif # _MKC_IMP.F_PROGNAME_MK
