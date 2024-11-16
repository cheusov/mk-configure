.PHONY : test_output
test_output:
	@${.OBJDIR}/cprog; \
	${.OBJDIR}/cxxprog; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
