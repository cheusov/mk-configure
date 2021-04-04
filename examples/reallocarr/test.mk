.PHONY : test_output
test_output:
	@${.OBJDIR}/prog | sed 's/0x[^ ][^ ]*/0xNNNNNNNN/'; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
