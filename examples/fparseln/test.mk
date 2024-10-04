.PHONY : test_output
test_output:
	@${.OBJDIR}/prog < input.txt | grep -v '^3 0'; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
