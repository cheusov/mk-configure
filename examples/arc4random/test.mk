.PHONY : test_output
test_output:
	@${.OBJDIR}/prog | sed 's/[0-9][0-9]*/nnn/'; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
