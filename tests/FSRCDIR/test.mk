.PHONY : test_output
test_output :
	@set -e; \
	\
	echo =========== all ============; \
	${MAKE} ${MAKEFLAGS} all 2>&1 | sed 's/ (continuing)//' | head -n 2; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
