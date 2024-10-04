MKC_CHECK_HEADERS      +=	sys/types.h,sys/stat.h

MKC_CHECK_SIZEOF       +=	int:sys/types.h

.include <mkc.configure.mk>

.if ${OPSYS:U} == "Linux"
VARIABLES_TO_CHECK=	HAVE_HEADER.sys_stat_h SIZEOF.int.sys_types_h
.include "test.mk"
.else
.PHONY: test
test:
	@echo '      skipped'; \
	: =========== cleandir ============; \
	${MAKE} cleandir > /dev/null
.endif

.include <mkc.mk>
