# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.include <mkc.configure.mk>

MKC_COMMON_DEFINES      +=	-D_GNU_SOURCE

MKC_CHECK_FUNCLIBS      +=	getprogname setprogname 
MKC_CHECK_FUNCS0        +=	getprogname:stdlib.h
MKC_CHECK_FUNCS1        +=	setprogname:stdlib.h
MKC_CHECK_VAR           +=	program_invocation_short_name:errno.h

.include <mkc.configure.mk>

.if ${HAVE_FUNCLIB.getprogname:U1} && \
    ${HAVE_FUNCLIB.setprogname:U1} && \
    ${HAVE_FUNC0.getprogname.stdlib_h:U1} && \
    ${HAVE_FUNC1.setprogname.stdlib_h:U1}
CFLAGS +=	-DMKC_PROGNAME_IS_FINE
.else
SRCS +=		${FEATURESDIR}/progname/progname.c
.endif
