.PHONY : test_output
test_output :
	@set -e; \
	\
	echo =========== all ============; \
	${MAKE} all 2>&1 | sed 's/ (continuing)//' | head -n 2; \
	\
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
