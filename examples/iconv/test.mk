.PHONY : test_output
test_output:
	@set -e; \
	${.OBJDIR}/hello_iconv | sed 's/i*n*compatible.*$$/ok/'; \
	${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1

.include <mkc.minitest.mk>
