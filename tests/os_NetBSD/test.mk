.PHONY : test_output
test_output:
.for v in ${VARIABLES_TO_CHECK}
	@echo ${v}=${${v}} | sed 's/=[1-9]/=n/g'
.endfor
	@echo CFLAGS=${CFLAGS:M-D*:N-D_FORTIFY_SOURCE=*} | sed 's/=[1-9]/=n/g'
	@${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1

.include <mkc.minitest.mk>
