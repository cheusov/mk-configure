.PHONY : test_output
test_output:
	@${.OBJDIR}/prog 2>/dev/null; echo "exit status = $$?"

.include <mkc.minitest.mk>
