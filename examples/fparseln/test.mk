.PHONY : test_output
test_output:
	@${.OBJDIR}/prog < input.txt

.include <mkc.minitest.mk>
