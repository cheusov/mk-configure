LIB  =		test
SRCS =		test.c

.PHONY : test_output
test_output :
	@set -e; \
	\
	echo =========== all ============; \
	${MAKE} clean >/dev/null 2>&1; \
	${MAKE} all >/dev/null 2>&1 && \
		echo built || echo failed; \
	${MAKE} clean >/dev/null 2>&1; \
	${MAKE} all USER_WARNS=4 >/dev/null 2>&1 && \
		echo built || echo failed; \
	${MAKE} clean >/dev/null 2>&1; \
	${MAKE} all USER_WARNERR=yes >/dev/null 2>&1 && \
		echo built || echo failed; \
	\
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
.include <mkc.mk>
