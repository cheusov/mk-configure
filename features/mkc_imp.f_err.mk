# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP_F_ERR_MK
_MKC_IMP_F_ERR_MK := 1

.include "mkc_imp.f_progname.mk"
.include "mkc_imp.f_macro.mk"

.include <mkc.conf.mk>

MKC_CHECK_HEADERS       +=	err.h
MKC_CHECK_FUNCLIBS      +=	err errx verr verrx
MKC_CHECK_FUNCS3        +=	err:err.h errx:err.h

MKC_CHECK_PROTOTYPES       +=	verr
MKC_PROTOTYPE_FUNC.verr     =	void verr(int, const char *, va_list)
MKC_PROTOTYPE_HEADERS.verr  =	stdarg.h err.h

MKC_CHECK_PROTOTYPES       +=	verrx
MKC_PROTOTYPE_FUNC.verrx    =	void verrx(int, const char *, va_list)
MKC_PROTOTYPE_HEADERS.verrx =	${MKC_PROTOTYPE_HEADERS.verr}

.include <mkc.conf.mk>

.if ${HAVE_FUNCLIB.err:U0} && ${HAVE_FUNCLIB.errx:U0} && \
    ${HAVE_FUNCLIB.verr:U0} && ${HAVE_FUNCLIB.verrx:U0} && \
    ${HAVE_FUNC3.err.err_h:U0} && ${HAVE_FUNC3.errx.err_h:U0} && \
    ${HAVE_PROTOTYPE.verr:U0} && ${HAVE_PROTOTYPE.verrx:U0}
CFLAGS +=	-DMKC_ERR_IS_FINE
.else
MKC_SRCS +=	${FEATURESDIR}/err/mkc_err.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_ERR

.endif #_MKC_IMP_F_ERR_MK
