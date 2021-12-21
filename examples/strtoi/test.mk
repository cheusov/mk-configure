.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/prog < ${.CURDIR}/input.in

.include <mkc.minitest.mk>
