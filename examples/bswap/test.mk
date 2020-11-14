.PHONY : test_output
test_output:
	@${.OBJDIR}/prog

.include <mkc.minitest.mk>
