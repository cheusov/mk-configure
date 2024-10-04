.PHONY : test_output
test_output:
.for v in ${VARIABLES_TO_CHECK}
	@echo ${v}=${${v}} | sed 's/=[48]/=n/g'
.endfor
	@echo CPPFLAGS=${CPPFLAGS:M-D*:N-D_FORTIFY_SOURCE=*} | sed 's/=[48]/=n/g'
	@${MAKE} cleandir > /dev/null 2>&1

.include <mkc.minitest.mk>
