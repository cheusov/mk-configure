VARIABLES_TO_CHECK=	HAVE_HEADER.vis_h

.PHONY : test_output
test_output:
.for v in ${VARIABLES_TO_CHECK}
	@echo ${v}=${${v}}
.endfor
	@${MAKE} ${MAKEFLAGS} cleandir > /dev/null 2>&1

.include <mkc.minitest.mk>
