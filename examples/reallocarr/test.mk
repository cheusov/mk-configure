.PHONY : test_output
test_output:
	@${.OBJDIR}/prog | sed 's/: [^ ][^ ]*/: NNNNNNNN/'; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
