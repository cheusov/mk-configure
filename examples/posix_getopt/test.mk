.PHONY : test_output
test_output:
	@${.OBJDIR}/prog -t 123 -n freeargument; \
	${.OBJDIR}/prog -n freeargument -t 123; \
	${.OBJDIR}/prog -t 123 -- -n freeargument; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
