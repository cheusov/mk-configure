.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello_SLIST < ${.CURDIR}/input.in; \
	\
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
