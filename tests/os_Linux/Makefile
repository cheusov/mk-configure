MKC_CHECK_HEADERS      +=	vis.h sys/types.h,sys/stat.h,fts.h

MKC_CHECK_HEADER_FILES +=	fts.h

MKC_CHECK_PROTOTYPES   +=		fts_read
MKC_PROTOTYPE_FUNC.fts_read =		FTSENT*fts_read(FTS*ftsp)
MKC_PROTOTYPE_HEADERS.fts_read =	sys/types.h sys/stat.h fts.h # spaces instead of comma

.include <mkc.init.mk>

.if ${OPSYS:U} == "Linux"
VARIABLES_TO_CHECK=	HAVE_HEADER.vis_h HAVE_HEADER.fts_h HAVE_HEADER_FILE.fts_h \
	HAVE_PROTOTYPE.fts_read
.include "test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'
.endif

.include <mkc.mk>
