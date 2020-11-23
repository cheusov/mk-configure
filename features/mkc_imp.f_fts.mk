# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################
.ifndef _MKC_IMP.F_FTS_MK
_MKC_IMP.F_FTS_MK := 1

MKC_REQUIRE_FUNCS1   +=	fts_read:sys/types.h,sys/stat.h,fts.h
MKC_REQUIRE_FUNCLIBS +=	fts_open:fts fts_read:fts fts_close:fts

MKC_CHECK_PROTOTYPES         +=	fts_open
MKC_PROTOTYPE_FUNC.fts_open   =	FTS *fts_open(char * const *, int, \
	int (*)(const FTSENT **, const FTSENT **));
MKC_PROTOTYPE_HEADERS.fts_open=	sys/types.h sys/stat.h fts.h

.include <mkc.conf.mk>

CPPFLAGS +=	-D_MKC_CHECK_FTS

.endif # _MKC_IMP.F_FTS_MK
