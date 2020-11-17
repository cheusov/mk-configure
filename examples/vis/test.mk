.PHONY : test_output
test_output:
	@${.OBJDIR}/prog; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
