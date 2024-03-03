.PHONY : test_output
test_output :
	@set -e; \
	echo =========== all ============; \
	find ${.OBJDIR} -type f | grep '/tool/.*[.]o$$' | sort | \
	    mkc_test_helper ${PREFIX:Q} ${.OBJDIR:Q} ${.CURDIR:Q}; \
	: =========== cleandir ============; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
