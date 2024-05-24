LIB  =		test
SRCS =		test.c

.PHONY : test_output
test_output :
	@set -e; \
	\
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} clean >/dev/null 2>&1; \
	${MAKE} ${MAKEFLAGS} all >/dev/null 2>&1 && \
		echo built || echo failed; \
	${MAKE} ${MAKEFLAGS} clean >/dev/null 2>&1; \
	${MAKE} ${MAKEFLAGS} all USER_WARNS=4 >/dev/null 2>&1 && \
		echo built || echo failed; \
	${MAKE} ${MAKEFLAGS} clean >/dev/null 2>&1; \
	${MAKE} ${MAKEFLAGS} all USER_WARNERR=yes >/dev/null 2>&1 && \
		echo built || echo failed; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
.include <mkc.mk>
