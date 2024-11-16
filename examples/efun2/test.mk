.PHONY : test_output
test_output:
	@${.OBJDIR}/prog; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
