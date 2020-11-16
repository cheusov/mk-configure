# Copyright (c) 2015 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_VIS_MK
_MKC_IMP_F_VIS_MK := 1

old :=			${MKC_COMMON_HEADERS}

MKC_COMMON_HEADERS =	stdlib.h

MKC_CHECK_FUNCS7   +=	strsenvisx:vis.h
MKC_CHECK_FUNCS6   +=	strenvisx:vis.h snvis:vis.h strsnvisx:vis.h
MKC_CHECK_FUNCS5   +=	nvis:vis.h strnvisx:vis.h svis:vis.h strsnvis:vis.h \
	strsvisx:vis.h
MKC_CHECK_FUNCS4   +=	vis:vis.h strnvis:vis.h strvisx:vis.h strsvis:vis.h
MKC_CHECK_FUNCS3   +=	strvis:vis.h stravis:vis.h

MKC_CHECK_HEADER_FILES  +=	vis.h

MKC_CHECK_FUNCLIBS +=	vis nvis strvis stravis strnvis strvisx strnvisx strenvisx svis snvis strsvis strsnvis strsvisx strsnvisx strsenvisx

.include <mkc.conf.mk>

MKC_COMMON_HEADERS :=	${old}
.undef old

.if ${HAVE_FUNCLIB.vis:U} != 1 || ${HAVE_FUNCLIB.nvis:U} != 1 || \
     ${HAVE_FUNCLIB.strvis:U} != 1 || ${HAVE_FUNCLIB.stravis:U} != 1 || \
     ${HAVE_FUNCLIB.strnvis:U} != 1 || ${HAVE_FUNCLIB.strvisx:U} != 1 || \
     ${HAVE_FUNCLIB.strnvisx:U} != 1 || ${HAVE_FUNCLIB.strenvisx:U} != 1 || \
     ${HAVE_FUNCLIB.svis:U} != 1 || ${HAVE_FUNCLIB.snvis:U} != 1 || \
     ${HAVE_FUNCLIB.strsvis:U} != 1 || ${HAVE_FUNCLIB.strsnvis:U} != 1 || \
     ${HAVE_FUNCLIB.strsvisx:U} != 1 || ${HAVE_FUNCLIB.strsnvisx:U} != 1 || \
     ${HAVE_FUNCLIB.strsenvisx:U} != 1
MKC_SRCS +=	${FEATURESDIR}/vis/vis.c ${FEATURESDIR}/vis/unvis.c
CPPFLAGS +=	-DHAVE_SVIS=0 -DHAVE_VIS=0
. else
CPPFLAGS +=	-DHAVE_SVIS=1 -DHAVE_VIS=1
.endif

CPPFLAGS +=	-D_MKC_CHECK_VIS

.endif #_MKC_IMP_F_VIS_MK
