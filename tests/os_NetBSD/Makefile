MKC_CHECK_HEADERS +=	vis.h

.include <mkc.init.mk>

.if ${OPSYS:U} == "NetBSD"
.include "test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'
.endif

.include <mkc.mk>
