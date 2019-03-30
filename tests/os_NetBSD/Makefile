MKC_CHECK_HEADERS      +=	vis.h
MKC_CHECK_HEADER_FILES +=	fts.h

.include <mkc.init.mk>

.if ${OPSYS:U} == "NetBSD"
VARIABLES_TO_CHECK=	HAVE_HEADER.vis_h HAVE_HEADER_FILE.fts_h
.include "test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'
.endif

.include <mkc.mk>
