.PHONY : test_output
test_output:
	@${.OBJDIR}/prog | sed 's/[0-9][0-9]*/nnn/'

.include <mkc.minitest.mk>
