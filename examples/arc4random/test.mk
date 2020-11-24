.PHONY : test_output
test_output:
	@LC_ALL=C; export LC_ALL; \
	${.OBJDIR}/prog | \
	sed -e 's/random: [0-9][0-9]*/random: nnn/' \
	    -e 's/0x[0-9a-f]*/0xH/'; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null

.include <mkc.minitest.mk>
