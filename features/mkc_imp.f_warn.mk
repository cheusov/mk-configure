# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP_F_WARN_MK
_MKC_IMP_F_WARN_MK := 1

.include <mkc_imp.f_progname.mk>

.include <mkc_imp.conf-cleanup.mk>

MKC_CHECK_HEADERS       +=	err.h
MKC_CHECK_FUNCLIBS      +=	warn warnx vwarn vwarnx
MKC_CHECK_FUNCS2        +=	warn:err.h warnx:err.h

MKC_CHECK_PROTOTYPES        +=	vwarn
MKC_PROTOTYPE_FUNC.vwarn     =	void vwarn(const char *, va_list)
MKC_PROTOTYPE_HEADERS.vwarn  =	stdarg.h err.h

MKC_CHECK_PROTOTYPES        +=	vwarnx
MKC_PROTOTYPE_FUNC.vwarnx    =	void vwarnx(const char *, va_list)
MKC_PROTOTYPE_HEADERS.vwarnx =	${MKC_PROTOTYPE_HEADERS.vwarn}

.include <mkc_imp.conf-cleanup.mk>

.if ${HAVE_FUNCLIB.warn:U0} && ${HAVE_FUNCLIB.warnx:U0} && \
    ${HAVE_FUNCLIB.vwarn:U0} && ${HAVE_FUNCLIB.vwarnx:U0} && \
    ${HAVE_FUNC2.warn.err_h:U0} && ${HAVE_FUNC2.warnx.err_h:U0} && \
    ${HAVE_PROTOTYPE.vwarn:U0} && ${HAVE_PROTOTYPE.vwarnx:U0}
CFLAGS +=	-DMKC_WARN_IS_FINE
.else
MKC_SRCS +=	${FEATURESDIR}/warn/warn.c
.endif

CPPFLAGS +=	-D_MKC_CHECK_WARN

.endif # _MKC_IMP_F_WARN_MK
