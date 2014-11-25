.if ${CC_TYPE:U} == gcc
cmd=echo Wall: ${HAVE_CC_OPT.-Wall}; echo Zhopa: ${HAVE_CC_OPT.-Zhopa}; echo errwarn=%all: ${HAVE_CC_OPT.-errwarn_%all}
.else
cmd=echo Wall: 1; echo Zhopa: 0; echo errwarn=%all: 1
.endif

.PHONY : test_output
test_output:
	@echo ========== lalala ==========; \
	${cmd}

.include <mkc.minitest.mk>
