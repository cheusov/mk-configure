.PHONY : test_output
test_output:
	@IFS=; ${.OBJDIR}/prog < expect.out | awk '{print "echo", $$0}' | sh -e; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
