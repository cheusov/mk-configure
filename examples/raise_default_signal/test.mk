.PHONY : test_output
test_output:
	@${.OBJDIR}/prog 2>/dev/null; echo "exit status = $$?"; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
