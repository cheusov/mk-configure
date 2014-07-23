# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.include <mkc.configure.mk>

.include <mkc_imp.f_progname.mk>

.include <mkc.configure.mk>

MKC_CHECK_HEADERS       +=	err.h
MKC_CHECK_FUNCLIBS      +=	warn warnx vwarn vwarnx
MKC_CHECK_FUNCS2        +=	warn:err.h warnx:err.h vwarn:err.h vwarnx:err.h

.include <mkc.configure.mk>

.if ${HAVE_FUNCLIB.warn:U1} && ${HAVE_FUNCLIB.warnx:U1} && \
    ${HAVE_FUNCLIB.vwarn:U1} && ${HAVE_FUNCLIB.vwarnx:U1} && \
    ${HAVE_FUNC2.warn.err_h:U1} && ${HAVE_FUNC2.warnx.err_h:U1} && \
    ${HAVE_FUNC2.vwarn.err_h:U1} && ${HAVE_FUNC2.vwarnx.err_h:U1}
CFLAGS +=	-DMKC_WARN_IS_FINE
.else
SRCS +=		${FEATURESDIR}/warn/warn.c
.endif
