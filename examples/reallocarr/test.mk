.PHONY : test_output
test_output:
	@${.OBJDIR}/prog | sed 's/: [^ ][^ ]*/: NNNNNNNN/'; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
