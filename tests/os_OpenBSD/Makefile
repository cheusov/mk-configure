MKC_CHECK_HEADER_FILES +=	vis.h

.include <mkc.init.mk>

.if ${OPSYS:U} == "OpenBSD"
VARIABLES_TO_CHECK=	HAVE_HEADER_FILE.vis_h
.include "../os_NetBSD/test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'
.endif

.include <mkc.mk>
