# Copyright (c) 2015 by Aleksey Cheusov
#
# See LICENSE file in the distribution.

.ifndef _MKC_IMP_F_VIS_MK
_MKC_IMP_F_VIS_MK := 1

.if ${OPSYS} == "NetBSD"
old :=			${MKC_COMMON_HEADERS}

MKC_COMMON_HEADERS =	stdlib.h

MKC_CHECK_FUNCS7   +=	strsenvisx:vis.h
MKC_CHECK_FUNCS6   +=	strenvisx:vis.h snvis:vis.h strsnvisx:vis.h
MKC_CHECK_FUNCS5   +=	nvis:vis.h strnvisx:vis.h svis:vis.h strsnvis:vis.h \
	strsvisx:vis.h
MKC_CHECK_FUNCS4   +=	vis:vis.h strnvis:vis.h strvisx:vis.h strsvis:vis.h \
	strnunvisx:vis.h unvis:vis.h
MKC_CHECK_FUNCS3   +=	strvis:vis.h stravis:vis.h strnunvis:vis.h \
	strunvisx:vis.h
MKC_CHECK_FUNCS2   +=	strunvis:vis.h

MKC_CHECK_HEADER_FILES  +=	vis.h

MKC_CHECK_FUNCLIBS +=	vis nvis strvis stravis strnvis strvisx strnvisx \
	strenvisx svis snvis strsvis strsnvis strsvisx strsnvisx strsenvisx \
	strunvis strnunvis strunvisx strnunvisx unvis

.include <mkc.conf.mk>

MKC_COMMON_HEADERS :=	${old}
.undef old
.endif # OpenBSD

.if ${HAVE_FUNCLIB.vis:U} != 1 || ${HAVE_FUNCLIB.nvis:U} != 1 || \
     ${HAVE_FUNCLIB.strvis:U} != 1 || ${HAVE_FUNCLIB.stravis:U} != 1 || \
     ${HAVE_FUNCLIB.strnvis:U} != 1 || ${HAVE_FUNCLIB.strvisx:U} != 1 || \
     ${HAVE_FUNCLIB.strnvisx:U} != 1 || ${HAVE_FUNCLIB.strenvisx:U} != 1 || \
     ${HAVE_FUNCLIB.svis:U} != 1 || ${HAVE_FUNCLIB.snvis:U} != 1 || \
     ${HAVE_FUNCLIB.strsvis:U} != 1 || ${HAVE_FUNCLIB.strsnvis:U} != 1 || \
     ${HAVE_FUNCLIB.strsvisx:U} != 1 || ${HAVE_FUNCLIB.strsnvisx:U} != 1 || \
     ${HAVE_FUNCLIB.strsenvisx:U} != 1
MKC_SRCS +=	${FEATURESDIR}/vis/vis.c
.endif

.if ${HAVE_FUNCLIB.strunvis:U} != 1 || ${HAVE_FUNCLIB.strnunvis:U} != 1 || \
     ${HAVE_FUNCLIB.strunvisx:U} != 1 || ${HAVE_FUNCLIB.strnunvisx:U} != 1 || \
     ${HAVE_FUNCLIB.unvis:U} != 1
MKC_SRCS +=	${FEATURESDIR}/vis/unvis.c
.endif

.if ${HAVE_FUNCLIB.vis:U} == 1
CPPFLAGS += -DHAVE_VIS
.endif
.if ${HAVE_FUNCLIB.nvis:U} == 1
CPPFLAGS += -DHAVE_NVIS
.endif
.if ${HAVE_FUNCLIB.strvis:U} == 1
CPPFLAGS += -DHAVE_STRVIS
.endif
.if ${HAVE_FUNCLIB.stravis:U} == 1
CPPFLAGS += -DHAVE_STRAVIS
.endif
.if ${HAVE_FUNCLIB.strnvis:U} == 1
CPPFLAGS += -DHAVE_STRNVIS
.endif
.if ${HAVE_FUNCLIB.strvisx:U} == 1
CPPFLAGS += -DHAVE_STRVISX
.endif
.if ${HAVE_FUNCLIB.strnvisx:U} == 1
CPPFLAGS += -DHAVE_STRNVISX
.endif
.if ${HAVE_FUNCLIB.strenvisx:U} == 1
CPPFLAGS += -DHAVE_STRENVISX
.endif
.if ${HAVE_FUNCLIB.svis:U} == 1
CPPFLAGS += -DHAVE_SVIS
.endif
.if ${HAVE_FUNCLIB.snvis:U} == 1
CPPFLAGS += -DHAVE_SNVIS
.endif
.if ${HAVE_FUNCLIB.strsvis:U} == 1
CPPFLAGS += -DHAVE_STRSVIS
.endif
.if ${HAVE_FUNCLIB.strsnvis:U} == 1
CPPFLAGS += -DHAVE_STRSNVIS
.endif
.if ${HAVE_FUNCLIB.strsvisx:U} == 1
CPPFLAGS += -DHAVE_STRSVISX
.endif
.if ${HAVE_FUNCLIB.strsnvisx:U} == 1
CPPFLAGS += -DHAVE_STRSNVISX
.endif
.if ${HAVE_FUNCLIB.strsenvisx:U} == 1
CPPFLAGS += -DHAVE_STRSENVISX
.endif

.if ${HAVE_FUNCLIB.strunvis:U} == 1
CPPFLAGS += -DHAVE_STRUNVIS
.endif
.if ${HAVE_FUNCLIB.strnunvis:U} == 1
CPPFLAGS += -DHAVE_STRNUNVIS
.endif
.if ${HAVE_FUNCLIB.strunvisx:U} == 1
CPPFLAGS += -DHAVE_STRUNVISX
.endif
.if ${HAVE_FUNCLIB.strnunvisx:U} == 1
CPPFLAGS += -DHAVE_STRNUNVISX
.endif
.if ${HAVE_FUNCLIB.unvis:U} == 1
CPPFLAGS += -DHAVE_UNVIS
.endif

CPPFLAGS +=	-D_MKC_CHECK_VIS

.endif #_MKC_IMP_F_VIS_MK

