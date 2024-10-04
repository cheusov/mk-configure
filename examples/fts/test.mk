SKIP_REGEXP=test[.]out[.]tmp|.*~$$

.PHONY : test_output
test_output:
	@set -e; rm -rf dir; mkdir dir; mkdir dir/subdir; \
	${.OBJDIR}/prog . | grep -Ev '${SKIP_REGEXP}'; \
	rm -rf dir; \
	${MAKE} cleandir > /dev/null

.include <mkc.minitest.mk>
