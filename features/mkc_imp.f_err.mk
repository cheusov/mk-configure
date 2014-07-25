# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.include <mkc.configure.mk>

.include <mkc_imp.f_progname.mk>

.include <mkc.configure.mk>

MKC_CHECK_HEADERS       +=	err.h
MKC_CHECK_FUNCLIBS      +=	err errx verr verrx
MKC_CHECK_FUNCS3        +=	err:err.h errx:err.h verr:err.h verrx:err.h

.include <mkc.configure.mk>

.if ${HAVE_FUNCLIB.err:U0} && ${HAVE_FUNCLIB.errx:U0} && \
    ${HAVE_FUNCLIB.verr:U0} && ${HAVE_FUNCLIB.verrx:U0} && \
    ${HAVE_FUNC3.err.err_h:U0} && ${HAVE_FUNC3.errx.err_h:U0} && \
    ${HAVE_FUNC3.verr.err_h:U0} && ${HAVE_FUNC3.verrx.err_h:U0}
CFLAGS +=	-DMKC_ERR_IS_FINE
.else
SRCS +=		${FEATURESDIR}/err/err.c
.endif
