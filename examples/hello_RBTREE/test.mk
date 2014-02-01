.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello_RBTREE < ${.CURDIR}/input.in; \
	\
	${MAKE} ${MAKEFLAGS} distclean > /dev/null

.include <mkc.minitest.mk>
