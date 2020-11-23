.PHONY : test_output
test_output:
.for v in ${VARIABLES_TO_CHECK}
	@echo ${v}=${${v}}
.endfor
	@echo CPPFLAGS=${CPPFLAGS:M-D*:N-D_FORTIFY_SOURCE=*}
	@${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1

.include <mkc.minitest.mk>
