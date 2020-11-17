.PHONY : test_output
test_output:
	@${.OBJDIR}/prog < input.txt; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
