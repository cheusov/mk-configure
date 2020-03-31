MKC_CHECK_HEADER_FILES +=	vis.h sys/types.h,sys/stat.h,fts.h

MKC_CHECK_HEADER_FILES +=       fts.h

MKC_CHECK_PROTOTYPES   +=       fts_read
MKC_PROTOTYPE_FUNC.fts_read =   FTSENT*fts_read(FTS*ftsp)
MKC_PROTOTYPE_HEADERS.fts_read= sys/types.h,sys/stat.h,fts.h

.include <mkc.init.mk>

.if ${OPSYS:U} == "OpenBSD"
VARIABLES_TO_CHECK=	HAVE_HEADER_FILE.vis_h HAVE_HEADER.fts_h HAVE_HEADER_FILE.fts_h \
	HAVE_PROTOTYPE.fts_read
.include "../os_NetBSD/test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'; \
	: =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null
.endif

.include <mkc.mk>
