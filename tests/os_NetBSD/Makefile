MKC_CHECK_HEADERS      +=	vis.h sys/types.h,sys/stat.h,fts.h

MKC_CHECK_HEADER_FILES +=	fts.h

MKC_CHECK_PROTOTYPES   +=	fts_read
MKC_PROTOTYPE_FUNC.fts_read =	FTSENT*fts_read(FTS*ftsp)
MKC_PROTOTYPE_HEADERS.fts_read=	sys/types.h,sys/stat.h,fts.h

MKC_CHECK_FUNCS1 +=		htobe32:sys/endian.h
MKC_FUNC_OR_DEFINE.htobe32 +=	yes

MKC_CHECK_FUNCS1 +=		bswap64:sys/types.h,machine/bswap.h
MKC_FUNC_OR_DEFINE.bswap64 +=	yes

.include <mkc.init.mk>

.if ${OPSYS:U} == "NetBSD"
VARIABLES_TO_CHECK=	HAVE_HEADER.vis_h HAVE_HEADER.fts_h HAVE_HEADER_FILE.fts_h \
	HAVE_PROTOTYPE.fts_read HAVE_FUNC1.htobe32.sys_endian_h \
	HAVE_FUNC1.bswap64.machine_bswap_h
.include "test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'; \
	: =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null
.endif

.include <mkc.mk>
