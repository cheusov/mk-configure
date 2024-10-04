.PHONY : test_output
test_output:
	@${.OBJDIR}/prog 2>&1 >/dev/null; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
